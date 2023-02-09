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
    describe "Tic tac toe"
        [ test "X plays first"
            -- (Expect.equal (Next X) (decide emptyGrid))
            -- ((decide emptyGrid) |> Expect.equal (Next X))
            (emptyGrid
                |> decide
                |> Expect.equal (Next X)
            )
        , test "O plays second"
            (emptyGrid
                |> play X
                |> decide
                |> Expect.equal (Next O)
            )
        , test "Players take turns"
            (emptyGrid
                |> play X
                |> play O
                |> decide
                |> Expect.equal (Next X)
            )
        , test "X Wins"
            --    |   |
            --  O | O |
            --  X | X | X
            (emptyGrid
                |> play X
                |> play O
                |> play X
                |> play O
                |> play X
                |> decide
                |> Expect.equal (Win X)
            )
        ]



-- function play(player:Player, grid: Grid): Grid {}


play : Player -> Grid -> Grid
play player grid =
    player :: grid



-- function decide(grid: string): Decision {}


type alias Grid =
    List Player


decide : Grid -> Decision
decide grid =
    if
        (grid |> List.filter (\player -> player == X) |> List.length)
            == 3
    then
        Win X

    else
        case grid of
            lastPlayer :: tail ->
                switch lastPlayer

            [] ->
                Next X


switch : Player -> Decision
switch grid =
    if grid == X then
        Next O

    else
        Next X


emptyGrid : Grid
emptyGrid =
    []


type Player
    = X
    | O


type Decision
    = Next Player
    | Win Player
