module Lib.Maybe exposing (..)


or : Maybe a -> Maybe a -> Maybe a
or other first =
    case first of
        Just it ->
            Just it

        Nothing ->
            other
