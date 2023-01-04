module Decision exposing (Decision(..))

import Player exposing (Player)


type Decision
    = Next Player
    | WonBy Player
