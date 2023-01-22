module Domain.Position exposing (Position, toString)


type alias Position =
    { x : Int, y : Int }


toString : Position -> String
toString { x, y } =
    "{ x = " ++ String.fromInt x ++ ", y = " ++ String.fromInt y ++ " }"
