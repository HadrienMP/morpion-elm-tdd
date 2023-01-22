module Lib.List exposing (..)


isContainedIn : List a -> List a -> Bool
isContainedIn playerPositions columnPositions =
    columnPositions
        |> List.filter (\position -> List.member position playerPositions)
        |> List.length
        |> (==) (List.length columnPositions)
