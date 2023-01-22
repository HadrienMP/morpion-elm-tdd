module Domain.TicTacToe exposing (..)

import Domain.Decision as Decision exposing (Decision(..))
import Domain.Grid as Grid exposing (Grid)
import Domain.Player as Player exposing (Player(..))
import Domain.Position as Position exposing (..)
import Lib.List


decide : Grid -> Decision
decide grid =
    Decision.start grid
        |> Decision.try findWinner
        |> Decision.try findDraw
        |> Decision.withDefault nextPlayer


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
            movesOf grid player |> List.sortBy Position.toString
    in
    Grid.diagonals
        ++ Grid.rows
        ++ Grid.columns
        |> List.any (Lib.List.isContainedIn positions)


findDraw : Grid -> Maybe Decision
findDraw grid =
    if Grid.isFull grid then
        Just Draw

    else
        Nothing


movesOf : Grid -> Player -> List Position.Position
movesOf grid target =
    grid
        |> List.filter (\{ player } -> player == target)
        |> List.map .position


nextPlayer : Grid -> Decision
nextPlayer grid =
    Next <|
        case grid of
            [] ->
                X

            { player } :: _ ->
                Player.next player
