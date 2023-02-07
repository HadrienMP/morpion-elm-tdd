module Pages.Game exposing (Model, Msg(..), init, update, view)

import Element
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html.Attributes
import Json.Encode as Json
import Types exposing (Size)
import UI.Colors
import UI.Space



-- Init


type alias Model =
    ()


init : Model
init =
    ()



-- Update


type Msg
    = Restart


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        Restart ->
            ( init, Cmd.none )



-- View


view : Types.Images -> Size -> Model -> Element.Element Msg
view images availableSize model =
    Element.el
        [ Element.width Element.fill
        , Element.height Element.fill
        ]
    <|
        Element.column
            [ Element.centerX
            , Element.centerY
            , Element.spacing UI.Space.m
            ]
            [ displayGrid images availableSize model
            ]


minDimension : Size -> Int
minDimension size =
    min size.width size.height


displayGrid : Types.Images -> Size -> Model -> Element.Element Msg
displayGrid images availableSize model =
    Element.column
        [ Element.centerX
        , Element.centerY
        ]
        ([ [ ( 0, 0 ), ( 1, 0 ), ( 2, 0 ) ]
         , [ ( 0, 1 ), ( 1, 1 ), ( 2, 1 ) ]
         , [ ( 0, 2 ), ( 1, 2 ), ( 2, 2 ) ]
         ]
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


displayField : Size -> ( Int, Int ) -> Model -> Types.Images -> Element.Element Msg
displayField availableSize ( x, y ) model images =
    let
        cellSize =
            minDimension availableSize
                // 5
                |> max 100
                |> min 200

        borderWidth =
            max 1 <| cellSize // 90

        sides =
            { top =
                if y == 2 then
                    0

                else
                    borderWidth
            , bottom =
                if y == 0 then
                    0

                else
                    borderWidth
            , left =
                if x == 0 then
                    0

                else
                    borderWidth
            , right =
                if x == 2 then
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
        , Font.size 30
        , Font.center
        , Element.htmlAttribute <|
            Html.Attributes.property "style" <|
                Json.string <|
                    "cursor: url('"
                        ++ images.finnCursor
                        ++ "'), auto"
        ]
        { onPress = Nothing
        , label = Element.text (String.fromInt x ++ "," ++ String.fromInt y)
        }
