module Lib.Slides exposing (Background, Model, Msg(..), Slide, init, subscriptions, update, view)

import Browser.Events
import Dict
import Element exposing (Element)
import Element.Background as Background
import Element.Font as Font
import Html exposing (Html)
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
    Element.layout
        [ Font.color <| Element.rgb 1 1 1
        ]
        (model.slides
            |> List.indexedMap Tuple.pair
            |> Dict.fromList
            |> Dict.get model.currentSlide
            |> Maybe.map (slide context)
            |> Maybe.withDefault (Element.text <| "What slide now ? " ++ String.fromInt model.currentSlide)
        )


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
