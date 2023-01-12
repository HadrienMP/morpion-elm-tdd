module Spec exposing (suite)

import Expect
import Test exposing (Test, describe, test)


-- The rules of the tic tac toe game are the following:
--
--- a game is over when all fields are taken
--- a game is over when all fields in a column are taken by a player
--- a game is over when all fields in a row are taken by a player
--- a game is over when all fields in a diagonal are taken by a player
--- a player can take a field if not already taken
--- players take turns taking fields until the game is over
--- there are two player in the game (X and O)
--- X plays first
suite : Test
suite =
    describe "Tic Tac Toe"
        [ test "X plays first" <|
            \_ ->
                emptyGrid
                |> decide
                    |> Expect.equal (Next X)
        , test "O plays second" <|
             \_ ->
                 emptyGrid
                 |> plays X (0,0)
                 |> decide
                     |> Expect.equal (Next O)
        , test "X plays third" <|
             \_ ->
                 emptyGrid
                 |> plays X (0,0)
                 |> plays O (1,0)
                 |> decide
                     |> Expect.equal (Next X)
        , test "X wins" <|
             \_ ->
                -- X X X
                -- O O
                --
                 emptyGrid
                 |> plays X (0,0)
                 |> plays O (0,1)
                 |> plays X (1,0)
                 |> plays O (1,1)
                 |> plays X (2,0)
                 |> decide
                     |> Expect.equal (Win X)
         , test "X wins again" <|
                        \_ ->
                           -- X X X
                           -- O O
                           --
                            emptyGrid
                            |> plays X (2,0)
                            |> plays O (0,1)
                            |> plays X (1,0)
                            |> plays O (1,1)
                            |> plays X (0,0)
                            |> decide
                                |> Expect.equal (Win X)
            , test "X is defensive" <|
               \_ ->
                  -- X X
                  -- O O X
                  --
                   emptyGrid
                   |> plays X (0,0)
                   |> plays O (0,1)
                   |> plays X (1,0)
                   |> plays O (1,1)
                   |> plays X (2,1)
                   |> decide
                       |> Expect.equal (Next O)
         ]

type Player = X | O
type Decision = Next Player | Win Player

type alias Grid = List Move
emptyGrid : Grid
emptyGrid = []

type alias Position = {x:Int, y:Int}
type alias Move = {player: Player, position: Position}

plays: Player -> (Int, Int) -> Grid -> Grid
plays player (x,y) grid = {player=player, position={x=x,y=y}}::grid

decide : Grid -> Decision
decide grid =
    case grid of
        [] -> Next X
        {player,position}::_ ->
            case findWinner grid of
                Just winner -> Win winner
                Nothing -> Next <| other player

findWinner : Grid -> Maybe Player
findWinner grid =
    if List.length grid == 5 then Just X else Nothing

other : Player -> Player
other player =
    case player of
       X -> O
       O -> X