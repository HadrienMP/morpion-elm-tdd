module Spec exposing (suite)

import Board
import Decision exposing (..)
import Expect
import Player exposing (Player(..))
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Tic Tac Toe"
        [ test "X plays first" <|
            \_ ->
                Board.init
                    |> Board.decide
                    |> Expect.equal (Next X)
        , test "O plays second" <|
            \_ ->
                Board.init
                    -- Lisibilité plutôt que robustesse
                    |> Board.play { player = X, position = { x = 0, y = 0 } }
                    |> Board.decide
                    |> Expect.equal (Next O)
        , test "Players take turns" <|
            \_ ->
                Board.init
                    -- Lisibilité plutôt que robustesse
                    |> Board.play { player = X, position = { x = 0, y = 0 } }
                    |> Board.play { player = O, position = { x = 0, y = 2 } }
                    |> Board.decide
                    |> Expect.equal (Next X)
        , test "X wins" <|
            \_ ->
                Board.init
                    -- Lisibilité plutôt que robustesse
                    |> Board.play { player = X, position = { x = 0, y = 0 } }
                    |> Board.play { player = O, position = { x = 0, y = 2 } }
                    |> Board.play { player = X, position = { x = 1, y = 0 } }
                    |> Board.play { player = O, position = { x = 0, y = 1 } }
                    |> Board.play { player = X, position = { x = 2, y = 0 } }
                    -- |   | O | O |
                    -- |   |   |   |
                    -- | X | X | X |
                    |> Board.decide
                    |> Expect.equal (WonBy X)
        ]
