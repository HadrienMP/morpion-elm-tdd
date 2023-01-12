module Spec exposing (suite)

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
    describe "Todo rename"
        [ test "todo rename too" <|
            \_ ->
                "Haha"
                    |> Expect.equal "Haha"
        ]
