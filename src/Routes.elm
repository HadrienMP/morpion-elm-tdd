module Routes exposing (Route(..), humanName, nav, parse, stringUrl)

import Url exposing (Url)
import Url.Parser as Parser exposing (Parser)


type Route
    = Game
    | Presentation


stringUrl : Route -> String
stringUrl route =
    case route of
        Game ->
            "/"

        Presentation ->
            "/presentation"


humanName : Route -> String
humanName route =
    case route of
        Game ->
            "Jouer"

        Presentation ->
            "Présenter"


nav : List Route
nav =
    [ Game, Presentation ]


parse : Url -> Route
parse =
    Parser.parse parser >> Maybe.withDefault Game


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map Game Parser.top
        , Parser.map Presentation (Parser.s "presentation")
        ]
