module Pages.Game exposing (Model, Msg(..), init, update, view)

import Domain.Decision
import Domain.Grid as Grid
import Domain.Player as Player
import Domain.Position as Position
import Domain.TicTacToe
import Element exposing (Element, centerY)
import Element.Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Types exposing (Size)
import UI.Colors
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
    | Restart


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.lastDecision ) of
        ( PlayAt position, Domain.Decision.Next player ) ->
            let
                next =
                    Grid.play player ( position.x, position.y ) model.grid
            in
            ( { grid = next, lastDecision = Domain.TicTacToe.decide next }, Cmd.none )

        ( Restart, _ ) ->
            ( init, Cmd.none )

        _ ->
            ( model, Cmd.none )



-- View


view : Types.Images -> Size -> Model -> Element Msg
view images availableSize model =
    Element.el
        [ Element.inFront <|
            case model.lastDecision of
                Domain.Decision.Next _ ->
                    Element.none

                _ ->
                    Element.el
                        [ Element.width Element.fill
                        , Element.height Element.fill
                        , Element.Background.color <| UI.Colors.withAlpha 0.6 UI.Colors.background
                        ]
                    <|
                        Element.column
                            [ Element.centerX
                            , Element.paddingXY 0 UI.Space.m
                            , Element.centerY
                            , Element.rotate -0.1
                            , Element.spacing UI.Space.m
                            ]
                            [ displayDecision availableSize model
                            , Input.button
                                [ Element.Background.color UI.Colors.accent
                                , Font.color UI.Colors.onAccent
                                , Element.padding UI.Space.m
                                , Element.centerX
                                , Border.width 1
                                , Font.size <| minDimension availableSize // 14
                                ]
                                { onPress = Just Restart, label = Element.text "Play again !" }
                            ]
        , Element.width Element.fill
        , Element.height Element.fill
        ]
    <|
        displayGrid images availableSize model


displayDecision : Size -> Model -> Element Msg
displayDecision availableSize model =
    case model.lastDecision of
        Domain.Decision.Next _ ->
            Element.none

        Domain.Decision.Win player ->
            Element.el [ Font.size <| minDimension availableSize // 9 ] <|
                Element.text <|
                    Player.toString player
                        ++ " wins !"

        Domain.Decision.Draw ->
            Element.el [ Font.size <| minDimension availableSize // 9 ] <|
                Element.text <|
                    "It's a draw !"


minDimension : Size -> Int
minDimension size =
    min size.width size.height


displayGrid : Types.Images -> Size -> Model -> Element Msg
displayGrid images availableSize model =
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
                                    displayField availableSize position model images
                                )
                        )
                )
        )


displayField : Size -> Position.Position -> Model -> Types.Images -> Element Msg
displayField availableSize position model images =
    let
        cellSize =
            minDimension availableSize // 5

        borderWidth =
            max 1 <| cellSize // 90

        sides =
            { top =
                if position.y == 2 then
                    0

                else
                    borderWidth
            , bottom =
                if position.y == 0 then
                    0

                else
                    borderWidth
            , left =
                if position.x == 0 then
                    0

                else
                    borderWidth
            , right =
                if position.x == 2 then
                    0

                else
                    borderWidth
            }
    in
    Input.button
        [ Element.width <| Element.px <| cellSize
        , Element.height <| Element.px <| cellSize
        , Border.widthEach sides
        , Border.color <| UI.Colors.darken 10 UI.Colors.accent
        ]
        { onPress = Just <| PlayAt position
        , label =
            case
                Grid.findMoveAt position model.grid
            of
                Just { player } ->
                    Element.image
                        [ Element.width <| Element.px <| cellSize * 3 // 5
                        , Element.centerX
                        , centerY
                        ]
                    <|
                        case player of
                            Player.X ->
                                { src = images.finn
                                , description = "Finn from adventure time"
                                }

                            Player.O ->
                                { src = images.jake
                                , description = "Jake from adventure time"
                                }

                Nothing ->
                    Element.none
        }
