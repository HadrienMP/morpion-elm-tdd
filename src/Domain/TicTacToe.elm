module Domain.TicTacToe exposing (TicTacToe, play, start)

import Domain.Decision as Decision exposing (Decision(..))
import Domain.Grid as Grid exposing (Grid, Move)
import Domain.Player as Player exposing (Player)
import Domain.Position as Position
import Lib.List


type alias TicTacToe =
    { grid : Grid
    , lastDecision : Decision
    }


start : TicTacToe
start =
    Grid.empty |> decide


play : Move -> TicTacToe -> TicTacToe
play move ticTacToe =
    ticTacToe.grid
        |> Grid.play2 move
        |> decide


decide : Grid -> TicTacToe
decide grid =
    { grid = grid
    , lastDecision =
        Decision.start grid
            |> Decision.try findWinner
            |> Decision.try findDraw
            |> Decision.withDefault nextPlayer
    }


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
                Player.X

            { player } :: _ ->
                Player.next player
