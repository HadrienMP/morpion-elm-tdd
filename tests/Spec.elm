module Spec exposing (suite)

import Expect
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "asfkiasf"
        [ test "Hihi" <|
            \_ ->
                "Haha"
                    |> Expect.equal "Haha"
        ]
