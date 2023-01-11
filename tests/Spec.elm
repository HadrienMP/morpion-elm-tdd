module Spec exposing (suite)

import Expect
import Test exposing (Test, describe, test)


-- The rules of the tic tac toe game are the following:
--
--- a game is over when all fields are taken
--- a game is over when all fields in a column are taken by a player
--- a game is over when all fields in a row are taken by a player
--- a game is over when all fields in a diagonal are taken by a player
--- a player can take a field if not already taken
--- players take turns taking fields until the game is over
--- there are two player in the game (X and O)
--- X plays first
suite : Test
suite =
    describe "asfkiasf"
        [ test "Hihi" <|
            \_ ->
                "Haha"
                    |> Expect.equal "Haha"
        ]
