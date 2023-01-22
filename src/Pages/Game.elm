module Pages.Game exposing (..)

import Domain.Decision
import Domain.Grid
import Domain.Player as Player
import Domain.Position
import Domain.TicTacToe
import Element exposing (Element)
import Element.Border
import Element.Font
import Element.Input
import Types exposing (Size)
import UI.Space



-- Init


type alias Model =
    { grid : Domain.Grid.Grid
    , lastDecision : Domain.Decision.Decision
    }


init : Model
init =
    { grid = Domain.Grid.empty
    , lastDecision = Domain.TicTacToe.decide Domain.Grid.empty
    }



-- Update


type Msg
    = PlayAt Domain.Position.Position


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.lastDecision ) of
        ( PlayAt position, Domain.Decision.Next player ) ->
            let
                next =
                    Domain.Grid.play player ( position.x, position.y ) model.grid
            in
            ( { grid = next, lastDecision = Domain.TicTacToe.decide next }, Cmd.none )

        _ ->
            ( model, Cmd.none )



-- View


view : Model -> Element Msg
view model =
    Element.column
        [ Element.centerX
        , Element.centerY
        , Element.spacing UI.Space.m
        ]
        [ displayDecision model
        , displayGrid model
        ]


displayDecision : Model -> Element Msg
displayDecision model =
    Element.text <|
        case model.lastDecision of
            Domain.Decision.Next player ->
                Player.toString player ++ " is next"

            Domain.Decision.Win player ->
                Player.toString player ++ " wins !"

            Domain.Decision.Draw ->
                "It's a draw !"


displayGrid : Model -> Element Msg
displayGrid model =
    Element.column
        [ Element.centerX
        , Element.centerY
        ]
        (Domain.Grid.rows
            |> List.reverse
            |> List.map
                (\row ->
                    Element.row []
                        (row
                            |> List.map
                                (\position ->
                                    Element.Input.button
                                        [ Element.width <| Element.px 80
                                        , Element.height <| Element.px 80
                                        , Element.Border.width 1
                                        , Element.Font.center
                                        ]
                                        { onPress = Just <| PlayAt position
                                        , label =
                                            case model.grid |> List.filter (\move -> move.position == position) |> List.head of
                                                Just { player } ->
                                                    Element.text <| Player.toString player

                                                Nothing ->
                                                    Element.none
                                        }
                                )
                        )
                )
        )
