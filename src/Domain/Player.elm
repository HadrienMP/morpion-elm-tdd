module Domain.Player exposing (Player(..), all, next)


type Player
    = X
    | O


next : Player -> Player
next player =
    case player of
        X ->
            O

        O ->
            X


all : List Player
all =
    next_ [] |> List.reverse


next_ : List Player -> List Player
next_ list =
    case list of
        [] ->
            next_ (X :: list)

        X :: _ ->
            next_ (O :: list)

        O :: _ ->
            list
