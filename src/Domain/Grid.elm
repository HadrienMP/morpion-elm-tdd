module Domain.Grid exposing (Grid, Move, empty, isFull, play)

import Domain.Player exposing (Player)
import Domain.Position as Position


type alias Grid =
    List Move


type alias Move =
    { player : Player
    , position : Position.Position
    }


empty : Grid
empty =
    []


play : Player -> ( Int, Int ) -> Grid -> Grid
play player ( x, y ) grid =
    { player = player, position = { x = x, y = y } } :: grid


isFull : Grid -> Bool
isFull grid =
    (grid |> List.map .position |> List.sortBy Position.toString)
        == Position.all
