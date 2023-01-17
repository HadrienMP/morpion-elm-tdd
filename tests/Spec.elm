module Spec exposing (suite)

import Css exposing (noHistoricalLigatures)
import Expect
import Html exposing (th)
import Test exposing (Test, describe)



------------------------------------------------------------------------
-- Rules
------------------------------------------------------------------------
-- Basics
-- - there are two player in the game (X and O)
-- - the grid is 3x3
-- - X plays first
-- - players take turns taking fields until the game is over
-- - a player can take a field if not already taken
--
-- Ending
-- - a game is over when all fields are taken
-- - a game is over when all fields in a column are taken by a player
-- - a game is over when all fields in a row are taken by a player
-- - a game is over when all fields in a diagonal are taken by a player
------------------------------------------------------------------------


suite : Test
suite =
    describe "Tic tac toe"
        [ test "X plays first"
            (emptyGrid
                |> decide
                |> Expect.equal (Next X)
            )
        , test "O plays second"
            (emptyGrid
                |> play X ( 1, 1 )
                |> decide
                |> Expect.equal (Next O)
            )
        , test "Players take turns"
            (emptyGrid
                |> play X ( 1, 1 )
                |> play O ( 0, 0 )
                |> play X ( 0, 1 )
                |> decide
                |> Expect.equal (Next O)
            )
        , test "X wins on first line"
            --    |   |
            --  O | O |
            --  X | X | X
            (emptyGrid
                |> play X ( 0, 0 )
                |> play O ( 0, 1 )
                |> play X ( 1, 0 )
                |> play O ( 1, 1 )
                |> play X ( 2, 0 )
                |> decide
                |> Expect.equal (Win X)
            )
        , test "X wins on first line from right to left"
            --    |   |
            --  O | O |
            --  X | X | X
            (emptyGrid
                |> play X ( 2, 0 )
                |> play O ( 0, 1 )
                |> play X ( 1, 0 )
                |> play O ( 1, 1 )
                |> play X ( 0, 0 )
                |> decide
                |> Expect.equal (Win X)
            )
        ]


type alias Position =
    { x : Int, y : Int }


type alias Move =
    { player : Player
    , position : Position
    }



-- toto (tata titi)
-- toto <| tata titi
-- tata titi |> toto
-- Typescript
-- const play = (player: Player, position: [Int, Int], previousGrid: Grid): Grid


play : Player -> ( Int, Int ) -> Grid -> Grid
play player ( x, y ) grid =
    { player = player, position = { x = x, y = y } } :: grid


type alias Grid =
    List Move


emptyGrid : Grid
emptyGrid =
    []


decide : Grid -> Decision
decide grid =
    case findWinner grid of
        Just player ->
            Win player

        Nothing ->
            Next <| findNextPlayer grid


findNextPlayer : Grid -> Player
findNextPlayer grid =
    case grid of
        { player } :: _ ->
            switch player

        [] ->
            X


findWinner : Grid -> Maybe Player
findWinner grid =
    if
        3
            == (grid
                    |> List.filter (\{ player } -> player == X)
                    |> List.length
               )
    then
        Just X

    else
        Nothing


switch : Player -> Player
switch player =
    case player of
        X ->
            O

        O ->
            X


type Player
    = X
    | O


type Decision
    = Next Player
    | Win Player


test : String -> Expect.Expectation -> Test
test name body =
    Test.test name (\_ -> body)
