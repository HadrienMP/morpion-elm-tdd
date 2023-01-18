module Lib.Slides exposing (Background, Model, Msg(..), Slide, init, subscriptions, update, view)

import Browser.Events
import Dict
import Element exposing (Element)
import Element.Background as Background
import Element.Font as Font
import Element.Input
import Html exposing (Html)
import Html.Attributes
import Json.Decode as Decode



--
-- Init
--


type alias Model context =
    { currentSlide : Int
    , slides : List (Slide context Msg)
    }


init : List (Slide context Msg) -> Model context
init slides =
    { currentSlide = 0, slides = slides }


type alias Background context =
    { url : context -> String
    , opacity : Float
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


update : Msg -> Model context -> ( Model context, Cmd Msg )
update msg model =
    case msg of
        Next ->
            ( { model | currentSlide = model.currentSlide + 1 |> min (List.length model.slides - 1) }, Cmd.none )

        Previous ->
            ( { model | currentSlide = model.currentSlide - 1 |> max 0 }, Cmd.none )

        KeyPressed key ->
            case key of
                "PageUp" ->
                    ( { model | currentSlide = model.currentSlide - 1 |> max 0 }, Cmd.none )

                "ArrowLeft" ->
                    ( { model | currentSlide = model.currentSlide - 1 |> max 0 }, Cmd.none )

                "PageDown" ->
                    ( { model | currentSlide = model.currentSlide + 1 |> min (List.length model.slides - 1) }, Cmd.none )

                "ArrowRight" ->
                    ( { model | currentSlide = model.currentSlide + 1 |> min (List.length model.slides - 1) }, Cmd.none )

                _ ->
                    ( model, Cmd.none )



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


view : context -> Model context -> Html Msg
view context model =
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
        , Element.inFront <|
            Element.column
                [ Element.alignBottom
                , Element.width Element.fill
                ]
                [ Element.row
                    [ Font.size 40
                    , Font.light
                    , Font.color actionColor
                    , Element.alignRight
                    , Element.spacing 10
                    , Element.padding 20
                    ]
                    [ Element.Input.button []
                        { onPress = Just Previous
                        , label = Element.text "<"
                        }
                    , Element.Input.button []
                        { onPress = Just Next
                        , label = Element.text ">"
                        }
                    ]
                , progressBar model
                ]
        ]
    <|
        Element.row
            [ Element.height Element.fill
            , Element.htmlAttribute <|
                Html.Attributes.style "width" <|
                    String.fromInt (List.length model.slides * 100)
                        ++ "vw"
            , Element.htmlAttribute <|
                Html.Attributes.style "margin-left" <|
                    String.fromInt (-100 * model.currentSlide)
                        ++ "vw"
            , Element.htmlAttribute <| Html.Attributes.style "transition" "margin-left 0.5s cubic-bezier(0.86, 0, 0.07, 1) 0s"
            ]
            (model.slides
                |> List.indexedMap Tuple.pair
                |> List.map
                    (slide
                        { context = context
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
        , Background.color <| actionColor
        ]
        Element.none


actionColor : Element.Color
actionColor =
    Element.rgb255 0 112 255


progress : { currentSlide : Int, totalSlides : Int } -> Int
progress { currentSlide, totalSlides } =
    toFloat (totalSlides - 1)
        |> (/) (toFloat currentSlide)
        |> (*) 100
        |> round


slide :
    { context : context, totalSlides : Int }
    -> ( Int, Slide context msg )
    -> Element msg
slide { context, totalSlides } ( index, { content, background } ) =
    Element.el
        [ Background.color <| Element.rgb 0 0 0
        , Element.inFront <| Element.row [] []
        , Element.height Element.fill
        , Element.htmlAttribute <|
            Html.Attributes.style "flex" <|
                "0 0 "
                    ++ String.fromInt (100 // totalSlides)
                    ++ "%"
        ]
    <|
        Element.el
            [ Element.behindContent <| transparentBackground background context
            , Element.width Element.fill
            , Element.height Element.fill
            ]
        <|
            Element.el
                [ Element.width <| Element.maximum 920 <| Element.fill
                , Element.height <| Element.maximum 700 <| Element.fill
                , Element.centerX
                , Element.centerY
                , Element.padding 20
                ]
            <|
                content context


transparentBackground : Maybe (Background context) -> context -> Element msg
transparentBackground background context =
    case background of
        Just { url, opacity } ->
            Element.el
                [ Background.image <| url context
                , Element.alpha opacity
                , Element.width Element.fill
                , Element.height Element.fill
                ]
                Element.none

        Nothing ->
            Element.none
