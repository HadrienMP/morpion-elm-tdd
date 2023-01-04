module Player exposing (Player(..), other)


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
