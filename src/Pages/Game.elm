module Pages.Game exposing (..)

import Element
import Element.Border
import Element.Font
import Element.Input
import Types exposing (Size)



-- Init


type alias Model =
    ()


init : Model
init =
    ()



-- Update


type Msg
    = Noop


update : Msg -> Model -> Model
update msg model =
    case msg of
        Noop ->
            model



-- View


grid : List (List ( Int, Int ))
grid =
    List.range 0 2 |> List.map (\y -> List.range 0 2 |> List.map (\x -> ( x, y )))


view : Size -> Model -> Element.Element Msg
view size _ =
    Element.column
        [ Element.centerX
        , Element.centerY
        ]
        (grid
            |> List.reverse
            |> List.map (List.map (field size) >> Element.row [])
        )


field : Size -> ( Int, Int ) -> Element.Element Msg
field size ( x, y ) =
    Element.Input.button
        [ Element.width <| Element.px <| fieldSize size
        , Element.height <| Element.px <| fieldSize size
        , Element.Border.width 4
        , Element.Font.center
        ]
        { onPress = Nothing
        , label =
            Element.text <|
                String.fromInt x
                    ++ ", "
                    ++ String.fromInt y
        }


fieldSize : Size -> Int
fieldSize size =
    min size.width size.height // 5
