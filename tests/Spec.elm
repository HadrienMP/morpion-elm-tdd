module Spec exposing (suite)

import Css.Media exposing (grid)
import Expect
import Test exposing (Test, describe, test)



------------------------------------------------------------------------
-- Rules
------------------------------------------------------------------------
--- there are two player in the game (X and O)
--- the grid is 3x3
--- X plays first
--- players take turns taking fields until the game is over
--- a player can take a field if not already taken
--- a game is over when all fields are taken
--- a game is over when all fields in a column are taken by a player
--- a game is over when all fields in a row are taken by a player
--- a game is over when all fields in a diagonal are taken by a player
------------------------------------------------------------------------


suite : Test
suite =
    describe "Tic Tac Toe"
        [ test "X plays first" <|
            \_ ->
                emptyGrid
                    |> decide
                    |> Expect.equal (Next X)
        , test "O plays second" <|
            \_ ->
                emptyGrid
                    |> play X ( 1, 1 )
                    |> decide
                    |> Expect.equal (Next O)
        , test "players take turns" <|
            \_ ->
                emptyGrid
                    |> play X ( 1, 1 )
                    |> play O ( 0, 1 )
                    |> decide
                    |> Expect.equal (Next X)
        , test "X wins on first line" <|
            \_ ->
                --   |   |
                -- O | O |
                -- X | X | X
                emptyGrid
                    |> play X ( 0, 0 )
                    |> play O ( 0, 1 )
                    |> play X ( 1, 0 )
                    |> play O ( 1, 1 )
                    |> play X ( 2, 0 )
                    |> decide
                    |> Expect.equal (Win X)
        , test "X wins on sdfqfsd line" <|
            \_ ->
                --   |   |
                -- X | X | X
                -- O | O |
                emptyGrid
                    |> play X ( 0, 1 )
                    |> play O ( 0, 0 )
                    |> play X ( 1, 1 )
                    |> play O ( 1, 0 )
                    |> play X ( 2, 1 )
                    |> decide
                    |> Expect.equal (Win X)
        ]


emptyGrid : Grid
emptyGrid =
    []


type alias Move =
    { player : Player, field : { x : Int, y : Int } }


type alias Grid =
    List Move


type Player
    = X
    | O


type Decision
    = Next Player
    | Win Player


play : Player -> ( Int, Int ) -> Grid -> Grid
play player ( x, y ) grid =
    { player = player, field = { x = x, y = y } } :: grid


decide : Grid -> Decision
decide grid =
    case findWinner grid of
        Just player ->
            Win player

        _ ->
            grid |> nextPlayer |> Next


nextPlayer : Grid -> Player
nextPlayer grid =
    case grid of
        { player } :: _ ->
            player |> switch

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
    if player == O then
        X

    else
        O
