module Pages.Game exposing (Model, Msg(..), init, update, view)

import Domain.Decision
import Domain.Grid as Grid
import Domain.Player as Player
import Domain.Position as Position
import Domain.TicTacToe
import Element exposing (Element)
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import UI.Space



-- Init


type alias Model =
    { grid : Grid.Grid
    , lastDecision : Domain.Decision.Decision
    }


init : Model
init =
    { grid = Grid.empty
    , lastDecision = Domain.TicTacToe.decide Grid.empty
    }



-- Update


type Msg
    = PlayAt Position.Position


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.lastDecision ) of
        ( PlayAt position, Domain.Decision.Next player ) ->
            let
                next =
                    Grid.play player ( position.x, position.y ) model.grid
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
        (Grid.rows
            |> List.reverse
            |> List.map
                (\row ->
                    Element.row []
                        (row
                            |> List.map
                                (\position ->
                                    Input.button
                                        [ Element.width <| Element.px 80
                                        , Element.height <| Element.px 80
                                        , Border.width 1
                                        , Font.center
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
