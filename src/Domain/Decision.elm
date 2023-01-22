module Domain.Decision exposing (Analysis(..), Decision(..), start, try, withDefault)

import Domain.Grid exposing (Grid)
import Domain.Player exposing (Player)


type Decision
    = Next Player
    | Win Player
    | Draw


type Analysis
    = KeepGoing Grid
    | Decided Decision


start : Grid -> Analysis
start grid =
    KeepGoing grid


try : (Grid -> Maybe Decision) -> Analysis -> Analysis
try f analysis =
    case analysis of
        KeepGoing grid ->
            f grid
                |> Maybe.map Decided
                |> Maybe.withDefault analysis

        Decided _ ->
            analysis


withDefault : (Grid -> Decision) -> Analysis -> Decision
withDefault f analysis =
    case analysis of
        KeepGoing grid ->
            f grid

        Decided decision ->
            decision
