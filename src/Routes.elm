module Routes exposing (Route(..), parse, toString)

import Url exposing (Url)
import Url.Parser as Parser exposing (Parser)


type Route
    = Game
    | Presentation


toString : Route -> String
toString route =
    case route of
        Game ->
            "/"

        Presentation ->
            "/presentation"


parse : Url -> Route
parse =
    Parser.parse parser >> Maybe.withDefault Game


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map Game Parser.top
        , Parser.map Presentation (Parser.s "presentation")
        ]
