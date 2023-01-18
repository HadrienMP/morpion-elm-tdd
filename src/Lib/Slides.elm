module Lib.Slides exposing (Background, Model, Msg(..), Slide, init, subscriptions, update, view)

import Browser.Events
import Dict
import Element exposing (Element, alignBottom, spacing, width)
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
        (model.slides
            |> List.indexedMap Tuple.pair
            |> Dict.fromList
            |> Dict.get model.currentSlide
            |> Maybe.map (slide context)
            |> Maybe.withDefault (slideNotFound model)
        )


progressBar : Model context -> Element Msg
progressBar model =
    Element.el
        [ Element.height <| Element.px 8
        , Element.htmlAttribute <| Html.Attributes.style "width" <| String.fromInt (progress model) ++ "%"
        , Element.htmlAttribute <| Html.Attributes.style "transition" "width 1s"
        , Background.color <| actionColor
        ]
        Element.none


actionColor : Element.Color
actionColor =
    Element.rgb255 0 112 255


progress : Model context -> Int
progress model =
    toFloat (List.length model.slides - 1)
        |> (/) (toFloat model.currentSlide)
        |> (*) 100
        |> round


slideNotFound : Model context -> Element Msg
slideNotFound model =
    Element.column
        [ Element.centerX
        , Element.centerY
        , Element.spacing 20
        , Element.width <| Element.maximum 300 <| Element.fill
        ]
        [ Element.el [ Font.size 60, Font.bold ] <|
            Element.text "Oops"
        , Element.el [ Font.size 30 ] <|
            Element.text <|
                "I can't find the slide "
                    ++ pagination model
        , Element.paragraph [ Font.justify, Element.paddingEach { top = 40, right = 0, bottom = 0, left = 0 } ]
            [ Element.text <|
                "The library is probably broken, please create an issue with a link to your deck."
            ]
        ]


pagination : Model context -> String
pagination model =
    String.fromInt (model.currentSlide + 1)
        ++ "/"
        ++ String.fromInt (List.length model.slides)


slide : context -> Slide context msg -> Element msg
slide context { content, background } =
    Element.el
        [ Background.color <| Element.rgb 0 0 0
        , Element.width Element.fill
        , Element.height Element.fill
        , Element.inFront <| Element.row [] []
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
