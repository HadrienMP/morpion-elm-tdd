module Domain.Position exposing (..)


type alias Position =
    { x : Int, y : Int }


toString : Position -> String
toString { x, y } =
    "{ x = " ++ String.fromInt x ++ ", y = " ++ String.fromInt y ++ " }"


all : List Position
all =
    List.range 0 2
        |> List.map (\x -> List.range 0 2 |> List.map (Position x))
        |> List.foldr (++) []
