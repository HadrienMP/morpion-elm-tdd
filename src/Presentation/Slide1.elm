module Presentation.Slide1 exposing (..)

import Element
import Element.Border
import Element.Font
import ElmLogo
import Presentation.Types
import Presentation.UI.Space
import Presentation.UI.Text


view : Presentation.Types.Slide msg
view =
    { content =
        \images ->
            Element.column
                [ Element.centerX
                , Element.alignTop
                , Element.spacing Presentation.UI.Space.l
                ]
                [ Element.column [ Element.centerX ]
                    [ Presentation.UI.Text.xxl2
                        [ Element.Font.bold
                        , Element.centerX
                        ]
                        "Morpion"
                    , Presentation.UI.Text.xl2 [ Element.centerX ] "Elm + TDD"
                    ]
                , Element.row
                    [ Element.spaceEvenly
                    , Element.centerX
                    , Element.width Element.fill
                    ]
                    [ Element.image imageStyle
                        { src = images.tictactoe
                        , description = "Une grille de morpion"
                        }
                    , Element.el imageStyle <| ElmLogo.element imageSize
                    , Element.image imageStyle
                        { src = images.tdd
                        , description = "Le cycle red green refactor"
                        }
                    ]
                ]
    , background = Just { url = \images -> images.adventureTime, opacity = 0.3 }
    }


imageSize : Int
imageSize =
    130


imageStyle : List (Element.Attribute msg)
imageStyle =
    [ Element.width <| Element.px imageSize
    , Element.height <| Element.px imageSize
    , Element.clip
    , Element.Border.rounded 10
    ]
