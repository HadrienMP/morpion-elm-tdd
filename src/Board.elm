module Board exposing (Board, Move, Position, decide, get, init, play)

import Css exposing (Position)
import Decision exposing (Decision(..))
import List
import Player exposing (Player(..))


type Board
    = Board (List Move)


init : Board
init =
    Board
        []


type alias Position =
    { x : Int
    , y : Int
    }


type alias Move =
    { player : Player
    , position : Position
    }


play : Move -> Board -> Board
play move (Board board) =
    Board <| move :: board


get : Position -> Board -> Maybe Player
get position (Board board) =
    board
        |> List.filter (.position >> (==) position)
        |> List.head
        |> Maybe.map .player


nextPlayer : Board -> Player
nextPlayer (Board board) =
    case board of
        last :: _ ->
            Player.other last.player

        [] ->
            X


decide : Board -> Decision
decide board =
    case findWinner board of
        Just winner ->
            WonBy winner

        Nothing ->
            Next <| nextPlayer board


findWinner : Board -> Maybe Player
findWinner (Board board) =
    if (board |> List.filter (\x -> x.player == X) |> List.length) == 3 then
        Just X

    else
        Nothing
