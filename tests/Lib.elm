module Lib exposing (..)

import Expect
import Test exposing (Test)


test : String -> Expect.Expectation -> Test
test name body =
    Test.test name <| \_ -> body
