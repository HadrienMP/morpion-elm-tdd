module Board exposing (Board, Play, Position, empty, next, play)

import Css exposing (Position)
import List
import Player exposing (Player(..))
import Types


type Board
    = Board (List Play)


empty : Board
empty =
    Board
        []


type alias Position =
    { x : Int
    , y : Int
    }


type alias Play =
    { player : Player
    , position : Position
    }


play : Play -> Board -> Board
play move (Board board) =
    Board <| move :: board


nextPlayer : Board -> Player
nextPlayer (Board board) =
    case board of
        last :: _ ->
            Player.other last.player

        [] ->
            X


next : Board -> Types.Output
next board =
    case findWinner board of
        Just winner ->
            Types.Winner winner

        Nothing ->
            Types.Next <| nextPlayer board


findWinner : Board -> Maybe Player
findWinner (Board board) =
    if (board |> List.filter (\x -> x.player == X) |> List.length) == 3 then
        Just X

    else
        Nothing
