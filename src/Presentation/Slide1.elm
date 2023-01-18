module Presentation.Slide1 exposing (view)

import Element
import Element.Border as Border
import Element.Font as Font
import ElmLogo
import Presentation.Types
import Presentation.UI.Space as Space
import Presentation.UI.Text as Text


view : Presentation.Types.Slide msg
view =
    { content =
        \images ->
            Element.column
                [ Element.centerX
                , Element.alignTop
                , Element.spacing Space.l
                ]
                [ Element.column [ Element.centerX ]
                    [ Text.xxl2
                        [ Font.bold
                        , Element.centerX
                        ]
                        "Morpion"
                    , Text.xl2 [ Element.centerX ] "Elm + TDD"
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
    , background = Nothing
    }


imageSize : Int
imageSize =
    130


imageStyle : List (Element.Attribute msg)
imageStyle =
    [ Element.width <| Element.px imageSize
    , Element.height <| Element.px imageSize
    , Element.clip
    , Border.rounded 10
    ]
