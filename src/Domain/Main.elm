module Domain.Main exposing (..)

import Domain.Grid as Grid exposing (Grid)
import Domain.Player as Player exposing (Player(..))
import Domain.Position as Position exposing (..)
import Set


type Decision
    = Next Player
    | Win Player
    | Draw


decide : Grid -> Decision
decide grid =
    if Grid.isFull grid then
        Draw

    else
        findWinner grid |> Maybe.withDefault (nextPlayer grid)


findWinner : Grid -> Maybe Decision
findWinner grid =
    Player.all
        |> List.filter (hasWon grid)
        |> List.head
        |> Maybe.map Win


hasWon : Grid -> Player -> Bool
hasWon grid player =
    let
        positions =
            movesOf grid player
    in
    wonOnColumn positions
        || wonOnRow positions
        || wonOnDiagonal positions


wonOnDiagonal : List Position.Position -> Bool
wonOnDiagonal xMoves =
    let
        diagonals =
            [ [ { x = 0, y = 2 }
              , { x = 1, y = 1 }
              , { x = 2, y = 0 }
              ]
            , [ { x = 2, y = 2 }
              , { x = 1, y = 1 }
              , { x = 0, y = 0 }
              ]
            ]
    in
    List.member xMoves diagonals
        || List.member (List.reverse xMoves) diagonals


movesOf : Grid -> Player -> List Position.Position
movesOf grid target =
    grid
        |> List.filter (\{ player } -> player == target)
        |> List.map .position


wonOnRow : List Position.Position -> Bool
wonOnRow xMoves =
    xMoves |> List.map .y |> areAllTheSame


wonOnColumn : List Position.Position -> Bool
wonOnColumn xMoves =
    xMoves |> List.map .x |> areAllTheSame


areAllTheSame : List Int -> Bool
areAllTheSame list =
    List.length list
        == 3
        && (list
                |> Set.fromList
                |> Set.size
                |> (==) 1
           )


nextPlayer : Grid -> Decision
nextPlayer grid =
    Next <|
        case grid of
            [] ->
                X

            { player } :: _ ->
                Player.next player
