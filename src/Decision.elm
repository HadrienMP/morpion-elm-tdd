module Decision exposing (Decision(..), print)

import Player exposing (Player)


type Decision
    = Next Player
    | WonBy Player


print : Decision -> String
print decision =
    case decision of
        Next player ->
            "It's " ++ Player.print player ++ " turn"

        WonBy player ->
            "Congratulations " ++ Player.print player ++ " ! You won !"
