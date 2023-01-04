module Spec exposing (suite)

import Expect
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "stuff"
        [ test "asdfasf" <|
            \_ -> Expect.equal "hi" "ha"
        ]
