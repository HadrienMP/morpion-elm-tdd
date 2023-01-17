module Presentation.Library exposing (..)

import Css
import Dict
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import Html.Styled.Events as Evts exposing (..)


type Msg
    = Next
    | Previous


type alias Model context =
    { currentSlide : Int
    , slides : List (Slide context Msg)
    , context : context
    }


init : context -> List (Slide context Msg) -> Model context
init context slides =
    { currentSlide = 0, slides = slides, context = context }


type alias Slide context msg =
    { content : context -> Html msg, background : Maybe (context -> String) }


update : Msg -> Model context -> ( Model context, Cmd Msg )
update msg model =
    case msg of
        Next ->
            ( { model | currentSlide = model.currentSlide + 1 |> min (List.length model.slides - 1) }, Cmd.none )

        Previous ->
            ( { model | currentSlide = model.currentSlide - 1 |> max 0 }, Cmd.none )


view : Model context -> Html Msg
view model =
    Html.div
        [ Attr.css
            [ Css.position Css.relative
            , Css.height <| Css.pct 100
            ]
        ]
        [ model.slides
            |> List.indexedMap Tuple.pair
            |> Dict.fromList
            |> Dict.get model.currentSlide
            |> Maybe.map (slide model.context)
            |> Maybe.withDefault (Html.h1 [] [ Html.text <| "What slide now ? " ++ String.fromInt model.currentSlide ])
        , Html.div
            [ Attr.css
                [ Css.position Css.absolute
                , Css.right <| Css.rem 4
                , Css.bottom <| Css.rem 4
                ]
            ]
            [ Html.button [ Evts.onClick Previous ] [ Html.text "<" ]
            , Html.button [ Evts.onClick Next ] [ Html.text ">" ]
            ]
        ]


slide : context -> Slide context msg -> Html msg
slide context { content, background } =
    Html.div
        [ Attr.class "slide"
        , Attr.css
            [ Css.position Css.relative
            , Css.height <| Css.pct 100
            ]
        ]
        [ Html.div
            [ Attr.css
                [ case background of
                    Just it ->
                        Css.backgroundImage <| Css.url <| it context

                    Nothing ->
                        Css.backgroundImage Css.none
                , Css.backgroundSize <| Css.cover
                , Css.backgroundPosition Css.right
                , Css.position Css.absolute
                , Css.top Css.zero
                , Css.bottom Css.zero
                , Css.left Css.zero
                , Css.right Css.zero
                , Css.opacity <| Css.num 0.3
                ]
            ]
            []
        , Html.div
            [ Attr.css
                [ Css.position Css.absolute
                , Css.zIndex <| Css.int 10
                , Css.maxHeight <| Css.pct 98
                , Css.maxWidth <| Css.pct 98
                , Css.width <| Css.px 960
                , Css.height <| Css.px 700
                , Css.top <| Css.pct 50
                , Css.left <| Css.vw 50
                , Css.transform <| Css.translate2 (Css.pct -50) (Css.pct -50)
                , Css.overflow Css.hidden
                ]
            ]
            [ content context ]
        ]
