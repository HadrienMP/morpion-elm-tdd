module Domain.Position exposing (..)


type alias Position =
    { x : Int, y : Int }


toString : Position -> String
toString { x, y } =
    "{ x = " ++ String.fromInt x ++ ", y = " ++ String.fromInt y ++ " }"
