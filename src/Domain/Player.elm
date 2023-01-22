module Domain.Player exposing (Player(..), all, next, toString)


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
    nextInAll [] |> List.reverse


nextInAll : List Player -> List Player
nextInAll list =
    case list of
        [] ->
            nextInAll (X :: list)

        X :: _ ->
            nextInAll (O :: list)

        O :: _ ->
            list


toString : Player -> String
toString player =
    case player of
        X ->
            "X"

        O ->
            "O"
