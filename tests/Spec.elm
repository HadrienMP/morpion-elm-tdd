module Spec exposing (suite)

import Domain.Decision exposing (Decision(..))
import Domain.Player exposing (Player(..))
import Domain.TicTacToe as TicTacToe
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


play : Player -> ( Int, Int ) -> TicTacToe.TicTacToe -> TicTacToe.TicTacToe
play player ( x, y ) ticTacToe =
    TicTacToe.play { player = player, position = { x = x, y = y } } ticTacToe


suite : Test
suite =
    describe "Tic Tac Toe"
        [ describe "Basics"
            [ test "X plays first"
                (TicTacToe.start
                    |> .lastDecision
                    |> Expect.equal (Next X)
                )
            , describe "O plays second"
                [ test "X plays in the middle"
                    (TicTacToe.start
                        |> play X ( 1, 1 )
                        |> .lastDecision
                        |> Expect.equal (Next O)
                    )
                , test "X plays somewhere else"
                    (TicTacToe.start
                        |> play X ( 0, 0 )
                        |> .lastDecision
                        |> Expect.equal (Next O)
                    )
                ]
            , test "players take turns"
                --        | X(1,2) |
                -- O(0,1) | O(1,1) |
                -- X(0,0) | X(1,0) |
                (TicTacToe.start
                    |> play X ( 0, 0 )
                    |> play O ( 0, 1 )
                    |> play X ( 1, 0 )
                    |> play O ( 1, 1 )
                    |> play X ( 1, 2 )
                    |> .lastDecision
                    |> Expect.equal (Next O)
                )
            , test "attempts to play when it's not your turn are ignored"
                (let
                    before =
                        TicTacToe.start
                            |> play X ( 0, 0 )
                 in
                 before
                    |> play X ( 1, 0 )
                    |> Expect.equal before
                )
            , test "attempts to override a move are ignored"
                (let
                    before =
                        TicTacToe.start
                            |> play X ( 0, 0 )
                 in
                 before
                    |> play O ( 0, 0 )
                    |> Expect.equal before
                )
            ]
        , describe "attempts to plays outside the grid are ignored"
            [ test "left"
                (TicTacToe.start
                    |> play X ( -1, 0 )
                    |> Expect.equal TicTacToe.start
                )
            , test "right"
                (TicTacToe.start
                    |> play X ( 3, 0 )
                    |> Expect.equal TicTacToe.start
                )
            , test "top"
                (TicTacToe.start
                    |> play X ( 0, 3 )
                    |> Expect.equal TicTacToe.start
                )
            , test "bottom"
                (TicTacToe.start
                    |> play X ( 0, -1 )
                    |> Expect.equal TicTacToe.start
                )
            ]
        , test "Plays after the end of a grid are ignored"
            --        |        |
            -- O(0,1) | O(1,1) |
            -- X(0,0) | X(1,0) | X(2,0)
            (let
                before =
                    TicTacToe.start
                        |> play X ( 0, 0 )
                        |> play O ( 0, 1 )
                        |> play X ( 1, 0 )
                        |> play O ( 1, 1 )
                        |> play X ( 2, 0 )
             in
             before
                |> play O ( 2, 2 )
                |> Expect.equal before
            )
        , describe "Ending"
            [ describe "X wins on line"
                [ test "first, left to right"
                    --        |        |
                    -- O(0,1) | O(1,1) |
                    -- X(0,0) | X(1,0) | X(2,0)
                    (TicTacToe.start
                        |> play X ( 0, 0 )
                        |> play O ( 0, 1 )
                        |> play X ( 1, 0 )
                        |> play O ( 1, 1 )
                        |> play X ( 2, 0 )
                        |> .lastDecision
                        |> Expect.equal (Win X)
                    )
                , test "first, right to left"
                    --        |        |
                    -- O(0,1) | O(1,1) |
                    -- X(0,0) | X(1,0) | X(2,0)
                    (TicTacToe.start
                        |> play X ( 2, 0 )
                        |> play O ( 0, 1 )
                        |> play X ( 1, 0 )
                        |> play O ( 1, 1 )
                        |> play X ( 0, 0 )
                        |> .lastDecision
                        |> Expect.equal (Win X)
                    )
                , test "second"
                    -- O(0,2) | O(1,2) |
                    -- X(0,1) | X(1,1) | X(2,1)
                    --        |        |
                    (TicTacToe.start
                        |> play X ( 2, 1 )
                        |> play O ( 0, 2 )
                        |> play X ( 1, 1 )
                        |> play O ( 1, 2 )
                        |> play X ( 0, 1 )
                        |> .lastDecision
                        |> Expect.equal (Win X)
                    )
                , test "not right away"
                    -- y
                    -----|------------
                    -- 2 | X |   |
                    -- 1 | X | X | O
                    -- 0 | X | O | O
                    -----|------------
                    -- x | 0 | 1 | 2
                    (TicTacToe.start
                        |> play X ( 1, 1 )
                        |> play O ( 2, 0 )
                        |> play X ( 0, 1 )
                        |> play O ( 2, 1 )
                        |> play X ( 0, 0 )
                        |> play O ( 1, 0 )
                        |> play X ( 0, 2 )
                        |> .lastDecision
                        |> Expect.equal (Win X)
                    )
                ]
            , describe "X wins on column"
                [ test "first"
                    -- X |   |
                    -- X | O |
                    -- X | O |
                    (TicTacToe.start
                        |> play X ( 0, 0 )
                        |> play O ( 1, 0 )
                        |> play X ( 0, 1 )
                        |> play O ( 1, 1 )
                        |> play X ( 0, 2 )
                        |> .lastDecision
                        |> Expect.equal (Win X)
                    )
                ]
            , describe "X wins on diagonal"
                [ test "top left to bottom right"
                    -- y
                    -----|------------
                    -- 2 | X |   |
                    -- 1 | X | X |
                    -- 0 | O | O | X
                    -----|------------
                    -- x | 0 | 1 | 2
                    (TicTacToe.start
                        |> play X ( 2, 0 )
                        |> play O ( 0, 0 )
                        |> play X ( 1, 1 )
                        |> play O ( 1, 0 )
                        |> play X ( 0, 2 )
                        |> .lastDecision
                        |> Expect.equal (Win X)
                    )
                , test "bottom right to top left"
                    -- y
                    -----|------------
                    -- 2 | X |   |
                    -- 1 |   | X |
                    -- 0 | O | O | X
                    -----|------------
                    -- x | 0 | 1 | 2
                    (TicTacToe.start
                        |> play X ( 0, 2 )
                        |> play O ( 0, 0 )
                        |> play X ( 1, 1 )
                        |> play O ( 1, 0 )
                        |> play X ( 2, 0 )
                        |> .lastDecision
                        |> Expect.equal (Win X)
                    )
                , test "bottom left to top right"
                    -- y
                    -----|------------
                    -- 2 |   |   | X
                    -- 1 |   | X |
                    -- 0 | X | O | O
                    -----|------------
                    -- x | 0 | 1 | 2
                    (TicTacToe.start
                        |> play X ( 0, 0 )
                        |> play O ( 2, 0 )
                        |> play X ( 1, 1 )
                        |> play O ( 1, 0 )
                        |> play X ( 2, 2 )
                        |> .lastDecision
                        |> Expect.equal (Win X)
                    )
                , test "top right to bottom left"
                    -- y
                    -----|------------
                    -- 2 |   |   | X
                    -- 1 |   | X |
                    -- 0 | X | O | O
                    -----|------------
                    -- x | 0 | 1 | 2
                    (TicTacToe.start
                        |> play X ( 2, 2 )
                        |> play O ( 2, 0 )
                        |> play X ( 1, 1 )
                        |> play O ( 1, 0 )
                        |> play X ( 0, 0 )
                        |> .lastDecision
                        |> Expect.equal (Win X)
                    )
                , test "from the middle"
                    -- y
                    -----|------------
                    -- 2 |   |   | X
                    -- 1 |   | X |
                    -- 0 | X | O | O
                    -----|------------
                    -- x | 0 | 1 | 2
                    (TicTacToe.start
                        |> play X ( 1, 1 )
                        |> play O ( 2, 0 )
                        |> play X ( 2, 2 )
                        |> play O ( 1, 0 )
                        |> play X ( 0, 0 )
                        |> .lastDecision
                        |> Expect.equal (Win X)
                    )
                , test "on the last move"
                    (TicTacToe.start
                        |> play X ( 1, 1 )
                        |> play O ( 0, 1 )
                        |> play X ( 0, 0 )
                        |> play O ( 2, 2 )
                        |> play X ( 1, 2 )
                        |> play O ( 1, 0 )
                        |> play X ( 2, 0 )
                        |> play O ( 2, 1 )
                        |> play X ( 0, 2 )
                        |> .lastDecision
                        |> Expect.equal (Win X)
                    )
                ]
            , test "O wins on diagonal"
                -- y
                -----|------------
                -- 2 |   |   | O
                -- 1 |   | O | X
                -- 0 | O | X | X
                -----|------------
                -- x | 0 | 1 | 2
                (TicTacToe.start
                    |> play X ( 2, 0 )
                    |> play O ( 2, 2 )
                    |> play X ( 1, 0 )
                    |> play O ( 1, 1 )
                    |> play X ( 2, 1 )
                    |> play O ( 0, 0 )
                    |> .lastDecision
                    |> Expect.equal (Win O)
                )
            , describe "Draw when the whole grid is full"
                [ test "First example"
                    -- y
                    -----|------------
                    -- 2 | X | O | X
                    -- 1 | X | O | O
                    -- 0 | O | X | X
                    -----|------------
                    -- x | 0 | 1 | 2
                    (TicTacToe.start
                        |> play X ( 1, 0 )
                        |> play O ( 1, 1 )
                        |> play X ( 2, 0 )
                        |> play O ( 0, 0 )
                        |> play X ( 2, 2 )
                        |> play O ( 2, 1 )
                        |> play X ( 0, 1 )
                        |> play O ( 1, 2 )
                        |> play X ( 0, 2 )
                        |> .lastDecision
                        |> Expect.equal Draw
                    )
                , test "second example"
                    -- y
                    -----|------------
                    -- 2 | X | O | X
                    -- 1 | X | O | O
                    -- 0 | O | X | X
                    -----|------------
                    -- x | 0 | 1 | 2
                    (TicTacToe.start
                        |> play X ( 2, 2 )
                        |> play O ( 1, 1 )
                        |> play X ( 2, 0 )
                        |> play O ( 0, 0 )
                        |> play X ( 1, 0 )
                        |> play O ( 2, 1 )
                        |> play X ( 0, 1 )
                        |> play O ( 1, 2 )
                        |> play X ( 0, 2 )
                        |> .lastDecision
                        |> Expect.equal Draw
                    )
                ]
            ]
        ]



-- Équivalents
-- ###########
-- equal a b
-- b |> equal a
-- type = union type == comme union type en TS, un peu comme les enums
-- a :: [b,c] -> [a,b,c] (opération prepend)
-- Decision
