module Presentation.Slide1 exposing (..)

import Element
import Element.Border
import Element.Font
import ElmLogo
import Presentation.Types
import UI.Space
import UI.Text


view : Presentation.Types.Slide msg
view =
    { content =
        \images ->
            Element.column
                [ Element.centerX
                , Element.alignTop
                , Element.spacing UI.Space.xLarge
                ]
                [ Element.column [ Element.centerX ]
                    [ UI.Text.xLarge2
                        [ Element.Font.bold
                        , Element.centerX
                        ]
                        "Jeu du Morpion"
                    , UI.Text.large2 [ Element.centerX ] "Elm + TDD"
                    ]
                , Element.row
                    [ Element.spacing UI.Space.small
                    ]
                    [ Element.image imageStyle
                        { src = images.tictactoe
                        , description = "Une grille de morpion"
                        }
                    , Element.el imageStyle <| ElmLogo.element 140
                    , Element.image imageStyle
                        { src = images.tdd
                        , description = "Le cycle red green refactor"
                        }
                    ]
                ]
    , background = Just <| \images -> images.adventureTime
    }


imageStyle : List (Element.Attribute msg)
imageStyle =
    [ Element.width <| Element.px 140
    , Element.height <| Element.px 140
    , Element.clip
    , Element.Border.rounded 10
    ]
