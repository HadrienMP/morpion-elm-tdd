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
    describe "Tic Tac Toe"
        [ test "X plays first"
            -- Expect.equal (Next X) (decide empty)
            -- (decide empty |> Expect.equal (Next X))
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
        , test "players take turns"
            (emptyGrid
                |> play X ( 1, 1 )
                |> play O ( 0, 1 )
                |> decide
                |> Expect.equal (Next X)
            )
        , test "francois"
            --   |   |
            -- O | O |
            -- X | X | X
            (emptyGrid
                |> play X ( 0, 0 )
                |> play O ( 1, 0 )
                |> play X ( 0, 1 )
                |> play O ( 1, 1 )
                |> play X ( 0, 2 )
                |> decide
                |> Expect.equal (Wins X)
            )
        ]


type alias Grid =
    List Move


emptyGrid : Grid
emptyGrid =
    []



-- Mieux que les enum -> Les union types


type Player
    = X
    | O


type Decision
    = Next Player
    | Wins Player



-- function ticTacToe(grid: string): Jojo


type alias Move =
    { player : Player
    , position : ( Int, Int )
    }


play : Player -> ( Int, Int ) -> Grid -> Grid
play player position grid =
    { player = player, position = position } :: grid


decide : Grid -> Decision
decide grid =
    case grid of
        { player, position } :: _ ->
            if position == ( 0, 2 ) then
                Wins X

            else
                switch player

        [] ->
            Next X


switch : Player -> Decision
switch player =
    if player == X then
        Next O

    else
        Next X
