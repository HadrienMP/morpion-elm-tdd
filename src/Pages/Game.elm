module Pages.Game exposing (Model, Msg(..), init, update, view)

import Domain.Decision
import Domain.Grid as Grid
import Domain.Player as Player
import Domain.Position as Position
import Domain.TicTacToe
import Element exposing (Element, htmlAttribute)
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html.Attributes
import Types exposing (Size)
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


view : Size -> Model -> Element Msg
view availableSize model =
    Element.column
        [ Element.centerX
        , Element.centerY
        , Element.spacing UI.Space.m
        ]
        [ displayDecision availableSize model
        , displayGrid availableSize model
        ]


displayDecision : Size -> Model -> Element Msg
displayDecision availableSize model =
    Element.el [ Font.size <| minDimension availableSize // 9 ] <|
        Element.text <|
            case model.lastDecision of
                Domain.Decision.Next player ->
                    Player.toString player ++ " is next"

                Domain.Decision.Win player ->
                    Player.toString player ++ " wins !"

                Domain.Decision.Draw ->
                    "It's a draw !"


minDimension : Size -> Int
minDimension size =
    min size.width size.height


displayGrid : Size -> Model -> Element Msg
displayGrid availableSize model =
    let
        cellSize =
            minDimension availableSize // 5
    in
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
                                        [ Element.width <| Element.px <| cellSize
                                        , Element.height <| Element.px <| cellSize
                                        , Border.width 1
                                        ]
                                        { onPress = Just <| PlayAt position
                                        , label =
                                            case
                                                Grid.findMoveAt position model.grid
                                            of
                                                Just { player } ->
                                                    Element.el
                                                        [ Font.size <| cellSize - 10
                                                        , Element.centerX
                                                        , Element.centerY
                                                        , htmlAttribute <| Html.Attributes.style "transform" "translateY(10%)"
                                                        ]
                                                    <|
                                                        Element.text <|
                                                            Player.toString player

                                                Nothing ->
                                                    Element.none
                                        }
                                )
                        )
                )
        )
