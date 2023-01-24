module Domain.Grid exposing (Grid, Move, columns, diagonals, empty, findMoveAt, isFull, play, rows)

import Domain.Player exposing (Player)
import Domain.Position exposing (Position)
import Html.Attributes exposing (target)


type alias Grid =
    List Move


type alias Move =
    { player : Player
    , position : Position
    }


empty : Grid
empty =
    []


play : Player -> ( Int, Int ) -> Grid -> Grid
play player ( x, y ) grid =
    if
        hasBeenPlayed { x = x, y = y } grid
            || isLastPlayer player grid
            || isOutsideOfGrid x y
    then
        grid

    else
        { player = player, position = { x = x, y = y } } :: grid


isOutsideOfGrid : Int -> Int -> Bool
isOutsideOfGrid x y =
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
