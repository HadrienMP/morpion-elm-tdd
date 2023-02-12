module Spec exposing (suite)

import Expect
import Lib exposing (test)
import Test exposing (Test, describe)



------------------------------------------------------------------------
-- Rules
------------------------------------------------------------------------
-- Basics
-- - X plays first
-- - players take turns taking fields until the game is over
--
-- Ending
-- - a game is over when all fields are taken
-- - a game is over when all fields in a column are taken by a player
-- - a game is over when all fields in a row are taken by a player
-- - a game is over when all fields in a diagonal are taken by a player
--
-- To do last
-- - the grid is 3x3
-- - there are two player in the game (X and O)
-- - a player can take a field if not already taken
------------------------------------------------------------------------


suite : Test
suite =
    describe "Morpion"
        [ test "X plays first"
            (emptyGame
                |> expectNotWin X
            )
        , test "O plays second"
            (emptyGame
                |> play TopLeft
                |> expectNotWin O
            )
        , test "X plays third"
            (emptyGame
                |> play TopLeft
                |> play TopMiddle
                |> expectNotWin X
            )
        , test "X wins"
            (emptyGame
                |> play TopLeft
                |> play MiddleLeft
                |> play TopMiddle
                |> play MiddleMiddle
                |> play TopRight
                |> play MiddleRight
                |> play BottomLeft
                |> play BottomMiddle
                |> play BottomRight
                |> Expect.equal (Win X)
            )
        , test "Cannot play two times at the same position"
            (emptyGame
                |> play TopLeft
                |> play TopLeft
                |> expectNotWin O
            )
        , test "Cannot play two times at the same position on last move"
            (emptyGame
                |> play TopLeft
                |> play MiddleLeft
                |> play TopMiddle
                |> play MiddleMiddle
                |> play BottomRight
                |> play MiddleRight
                |> play BottomLeft
                |> play BottomMiddle
                |> play TopLeft
                |> expectNotWin X
            )
        ]


expectNotWin : Player -> Game -> Expect.Expectation
expectNotWin expectedPlayer status =
    case status of
        Win _ ->
            Expect.fail "Got Win, expected Not Win"

        NotWin grid ->
            Expect.equal (nextPlayer grid) expectedPlayer


play : Position -> Game -> Game
play target status =
    case status of
        Win _ ->
            status

        NotWin grid ->
            if List.member target (grid |> List.map .position) then
                NotWin grid

            else if
                (grid
                    |> List.filter (\{ player, position } -> player == X && List.member position [ TopLeft, TopMiddle, TopRight ])
                    |> List.length
                )
                    == 3
            then
                Win X

            else
                NotWin <| { position = target, player = nextPlayer grid } :: grid


type Player
    = X
    | O


type Position
    = TopLeft
    | TopMiddle
    | TopRight
    | MiddleLeft
    | MiddleMiddle
    | MiddleRight
    | BottomLeft
    | BottomMiddle
    | BottomRight


type alias Move =
    { position : Position, player : Player }


type alias Grid =
    List Move


nextPlayer : Grid -> Player
nextPlayer grid =
    case grid of
        [] ->
            X

        { player } :: _ ->
            case player of
                X ->
                    O

                O ->
                    X


emptyGame : Game
emptyGame =
    NotWin []


type Game
    = Win Player
    | NotWin Grid
