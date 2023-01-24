module Domain.Grid exposing (Grid, Move, columns, diagonals, empty, findMoveAt, isFull, play2, rows)

import Domain.Player exposing (Player)
import Domain.Position exposing (Position)


type alias Grid =
    List Move


type alias Move =
    { player : Player
    , position : Position
    }


empty : Grid
empty =
    []


play2 : Move -> Grid -> Grid
play2 move grid =
    if isLegal move grid then
        grid

    else
        move :: grid


isLegal : Move -> Grid -> Bool
isLegal move grid =
    isLastPlayer move.player grid
        || hasBeenPlayed move.position grid
        || isOutsideOfGrid move.position


isOutsideOfGrid : Position -> Bool
isOutsideOfGrid { x, y } =
    x < 0 || x > 2 || y < 0 || y > 2


isLastPlayer : Player -> Grid -> Bool
isLastPlayer player grid =
    (List.head grid |> Maybe.map .player) == Just player


hasBeenPlayed : Position -> Grid -> Bool
hasBeenPlayed position grid =
    grid |> List.map .position |> List.member position


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


findMoveAt : Position -> Grid -> Maybe Move
findMoveAt position grid =
    grid
        |> List.filter (\move -> move.position == position)
        |> List.head
