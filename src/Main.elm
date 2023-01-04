module Main exposing (Msg, main)

import Board
import Browser
import Css
import Decision exposing (Decision(..))
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import Html.Styled.Events as Evts
import Player


main : Program () Board.Board Msg
main =
    Browser.element
        { init = init
        , view = view >> Html.toUnstyled
        , update = update
        , subscriptions = always Sub.none
        }



-- Init


init : () -> ( Board.Board, Cmd Msg )
init _ =
    ( Board.init
    , Cmd.none
    )



-- Update


type Msg
    = Play Board.Position


update : Msg -> Board.Board -> ( Board.Board, Cmd Msg )
update msg board =
    case msg of
        Play position ->
            case Board.decide board of
                WonBy _ ->
                    ( board, Cmd.none )

                Next player ->
                    ( Board.play { player = player, position = position } board
                    , Cmd.none
                    )



-- View


view : Board.Board -> Html Msg
view board =
    Html.div
        []
        [ Html.h1 [] [ Html.text "Morpion" ]
        , Html.h2 [] [ Html.text "Démo de TDD en Elm @ Artisan Développeur" ]
        , Html.hr [] []
        , Html.h3 [] [ Html.text <| Decision.print <| Board.decide board ]
        , allPositions
            |> viewBoard board
        ]


type alias Matrix a =
    List (List a)


allPositions : Matrix Board.Position
allPositions =
    List.range 0 2
        |> List.repeat 3
        |> List.indexedMap Tuple.pair
        |> List.reverse
        |> List.map (\( lineIndex, columnIndices ) -> List.map (\x -> { x = x, y = lineIndex }) columnIndices)


viewBoard : Board.Board -> Matrix Board.Position -> Html Msg
viewBoard board =
    Html.table [ Attr.class "board", Attr.css [ Css.borderCollapse Css.collapse ] ]
        << List.map (viewLine board)


viewLine : Board.Board -> List Board.Position -> Html Msg
viewLine board =
    Html.tr [ Attr.class "line" ] << List.map (viewPosition board)


viewPosition : Board.Board -> Board.Position -> Html Msg
viewPosition board position =
    let
        ( style, field ) =
            case Board.get position board of
                Just player ->
                    ( [], Player.print player )

                Nothing ->
                    ( [ Css.color <| Css.rgb 174 174 174 ], "(" ++ String.fromInt position.x ++ "," ++ String.fromInt position.y ++ ")" )
    in
    Html.td
        [ Attr.class "position"
        , Attr.css
            [ Css.border3 (Css.px 1) Css.solid (Css.rgb 0 0 0)
            ]
        ]
        [ Html.button
            [ Evts.onClick <| Play position
            , Attr.css
                ([ Css.backgroundColor Css.transparent
                 , Css.padding <| Css.rem 0.4
                 , Css.border Css.zero
                 , Css.cursor Css.pointer
                 , Css.width <| Css.rem 3
                 , Css.height <| Css.rem 3
                 , Css.boxSizing Css.borderBox
                 ]
                    ++ style
                )
            ]
            [ Html.text field ]
        ]
