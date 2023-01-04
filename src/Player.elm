module Player exposing (Player(..), other, print)


type Player
    = X
    | O


other : Player -> Player
other player =
    case player of
        X ->
            O

        O ->
            X


print : Player -> String
print player =
    case player of
        X ->
            "X"

        O ->
            "O"
