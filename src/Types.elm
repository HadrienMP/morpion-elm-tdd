module Types exposing (Output(..))

import Player exposing (Player)


type Output
    = Next Player
    | Winner Player
