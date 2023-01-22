module Domain.Grid exposing (Grid, Move, columns, diagonals, empty, isFull, play, rows)

import Domain.Player exposing (Player)
import Domain.Position as Position exposing (Position)


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
    List.length grid == (3 * 3)


columns : List (List Position)
columns =
    List.range 0 2 |> List.map column


column : Int -> List Position
column x =
    List.range 0 2 |> List.map (Position x)


rows : List (List Position)
rows =
    List.range 0 2 |> List.map row


row : Int -> List Position
row y =
    List.range 0 2 |> List.map (\x -> { x = x, y = y })


diagonals : List (List Position)
diagonals =
    [ List.range 0 2 |> List.map (\a -> { x = a, y = a })
    , List.range 0 2 |> List.map (\a -> { x = a, y = a - 2 |> abs })
    ]
