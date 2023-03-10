module Lib.Slides exposing (Background(..), ImageBackground, Model, Msg(..), Size, Slide, init, subscriptions, update, view)

import Browser.Events
import Browser.Navigation
import Element exposing (Element)
import Element.Background as Background
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Html.Attributes
import Json.Decode as Decode
import Lib.Basics exposing (andSubtract)
import Url
import Url.Builder



--
-- Init
--


type alias Model context =
    { currentSlide : Int
    , slides : List (Slide context Msg)
    , background : Maybe (Background context)
    , accent : Element.Color
    }


type Background context
    = Image (ImageBackground context)
    | Color { r : Int, g : Int, b : Int, a : Float }


type alias ImageBackground context =
    { url : context -> String
    , opacity : Float
    }


init : List (Slide context Msg) -> Url.Url -> Model context
init slides url =
    { currentSlide =
        Url.toString url
            |> String.split "#"
            |> List.reverse
            |> List.head
            |> Maybe.andThen String.toInt
            |> Maybe.withDefault 1
            |> andSubtract 1
    , slides = slides
    , background = Just <| Color { r = 0, b = 0, g = 0, a = 0 }
    , accent = Element.rgb255 0 112 255
    }


type alias Slide context msg =
    { content : context -> Element msg
    , background : Maybe (Background context)
    }



--
-- Update
--


type Msg
    = Next
    | Previous
    | KeyPressed String


update : Browser.Navigation.Key -> Msg -> Model context -> ( Model context, Cmd Msg )
update navKey msg model =
    case msg of
        Next ->
            nextSlide navKey model

        Previous ->
            previousSlide navKey model

        KeyPressed key ->
            case key of
                "PageUp" ->
                    previousSlide navKey model

                "ArrowLeft" ->
                    previousSlide navKey model

                "PageDown" ->
                    nextSlide navKey model

                "ArrowRight" ->
                    nextSlide navKey model

                _ ->
                    ( model, Cmd.none )


previousSlide : Browser.Navigation.Key -> Model context -> ( Model context, Cmd Msg )
previousSlide key model =
    model.currentSlide
        - 1
        |> max 0
        |> changeSlide key model


nextSlide : Browser.Navigation.Key -> Model context -> ( Model context, Cmd Msg )
nextSlide key model =
    model.currentSlide
        + 1
        |> min (List.length model.slides - 1)
        |> changeSlide key model


changeSlide : Browser.Navigation.Key -> Model context -> Int -> ( Model context, Cmd Msg )
changeSlide key model next =
    ( { model | currentSlide = next }
    , Browser.Navigation.pushUrl key <|
        Url.Builder.relative [ "#" ++ (String.fromInt <| next + 1) ] []
    )



--
-- Subscriptions
--


subscriptions : Model context -> Sub Msg
subscriptions _ =
    Browser.Events.onKeyDown
        (Decode.field "key" Decode.string
            |> Decode.map KeyPressed
        )



--
-- View
--


type alias Size =
    { width : Int, height : Int }


view : Size -> context -> Model context -> Html Msg
view size context model =
    Element.layoutWith
        { options =
            [ Element.focusStyle
                { borderColor = Nothing
                , backgroundColor = Nothing
                , shadow = Nothing
                }
            ]
        }
        [ Font.color <| Element.rgb 1 1 1
        , Element.clip
        , model.background
            |> Maybe.map (displayBackground context)
            |> Maybe.withDefault Element.none
            |> Element.behindContent
        , Element.inFront <|
            Element.column
                [ Element.alignBottom
                , Element.width Element.fill
                ]
                [ Element.row
                    [ Font.size 40
                    , Font.light
                    , Font.color <| actionColor model
                    , Element.alignRight
                    , Element.spacing 10
                    , Element.padding 20
                    ]
                    [ Input.button []
                        { onPress = Just Previous
                        , label = Element.text "<"
                        }
                    , Input.button []
                        { onPress = Just Next
                        , label = Element.text ">"
                        }
                    ]
                , progressBar model
                ]
        ]
    <|
        Element.row
            [ Element.height <| Element.px <| size.height
            , Element.width <| Element.px <| List.length model.slides * size.width
            , Element.htmlAttribute <|
                Html.Attributes.style "margin-left" <|
                    String.fromInt (model.currentSlide * -size.width)
                        ++ "px"
            , Element.htmlAttribute <|
                Html.Attributes.style
                    "transition"
                    "margin-left 0.5s cubic-bezier(0.86, 0, 0.07, 1) 0s"
            ]
            (model.slides
                |> List.indexedMap Tuple.pair
                |> List.map
                    (slide
                        { context = context
                        , size = size
                        , totalSlides = List.length model.slides
                        }
                    )
            )


progressBar : Model context -> Element Msg
progressBar model =
    Element.el
        [ Element.height <| Element.px 8
        , Element.htmlAttribute <|
            Html.Attributes.style "width" <|
                String.fromInt
                    (progress
                        { currentSlide = model.currentSlide
                        , totalSlides = List.length model.slides
                        }
                    )
                    ++ "%"
        , Element.htmlAttribute <| Html.Attributes.style "transition" "width 1s"
        , Background.color <| actionColor model
        ]
        Element.none


actionColor : Model context -> Element.Color
actionColor model =
    model.accent


progress : { currentSlide : Int, totalSlides : Int } -> Int
progress { currentSlide, totalSlides } =
    toFloat (totalSlides - 1)
        |> (/) (toFloat currentSlide)
        |> (*) 100
        |> round


slide :
    { context : context
    , size : Size
    , totalSlides : Int
    }
    -> ( Int, Slide context msg )
    -> Element msg
slide { context, size, totalSlides } ( _, { content, background } ) =
    Element.el
        [ Element.inFront <| Element.row [] []
        , Element.height Element.fill
        , Element.clip
        , Element.htmlAttribute <|
            Html.Attributes.style "flex" <|
                "0 0 "
                    ++ String.fromInt (100 // totalSlides)
                    ++ "%"
        , background
            |> Maybe.map (displayBackground context)
            |> Maybe.withDefault Element.none
            |> Element.behindContent
        ]
    <|
        Element.el
            [ Element.width <| Element.px slideSize.width
            , Element.height <| Element.px slideSize.height
            , Element.scale <| scaleFactor size
            , Element.htmlAttribute <|
                Html.Attributes.style
                    "transform-origin"
                    "top"
            , Element.padding 20
            , Element.centerX
            , Element.centerY
            ]
        <|
            content context


slideSize : Size
slideSize =
    { width = 920, height = 700 }


scaleFactor : Size -> Float
scaleFactor size =
    (toFloat size.width / toFloat slideSize.width)
        |> min (toFloat size.height / toFloat slideSize.height)
        |> min 1


displayBackground : context -> Background context -> Element msg
displayBackground context background =
    case background of
        Image { url, opacity } ->
            Element.el
                [ Background.image <| url context
                , Element.alpha opacity
                , Element.width Element.fill
                , Element.height Element.fill
                ]
                Element.none

        Color { r, g, b, a } ->
            Element.el
                [ Background.color <| Element.rgba255 r g b a
                , Element.width Element.fill
                , Element.height Element.fill
                ]
                Element.none
