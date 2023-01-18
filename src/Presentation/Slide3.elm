module Presentation.Slide3 exposing (..)

import Element
import Element.Font
import ElmLogo
import Presentation.Types
import UI
import UI.Space
import UI.Text


view : Presentation.Types.Slide msg
view =
    { content =
        \images ->
            Element.column [ Element.centerX, Element.spacing UI.Space.xLarge ]
                [ Element.row [ Element.spacing UI.Space.xLarge ]
                    [ Element.el [ Element.alignTop ] <| ElmLogo.element 140
                    , Element.column [ Element.spacing UI.Space.medium ]
                        [ UI.Text.xLarge2 [ Element.Font.bold ] "Elm"
                        , UI.ul []
                            [ "Evan Czapliki : 2012"
                            , "Frontend"
                            , "Fonctionnel"
                            , "Minimaliste"
                            , "Super système de types"
                            ]
                        ]
                    ]
                , UI.hr
                , Element.row [ Element.spacing UI.Space.xLarge ]
                    [ Element.el [ Element.alignTop ] <|
                        Element.image
                            [ Element.width <| Element.px 140
                            , Element.height <| Element.px 140
                            ]
                            { src = images.tdd
                            , description = "Le cycle TDD: Red Green Refactor"
                            }
                    , Element.column [ Element.spacing UI.Space.medium ]
                        [ UI.Text.xLarge2 [ Element.Font.bold ] "TDD"
                        , UI.ul []
                            [ "Kent Beck : 1999"
                            , "Technique de design"
                            , "Cycle :"
                            ]
                        , UI.ol [ Element.moveRight <| toFloat UI.Space.xLarge ] [ "1 test simple", "correction évidente/anarque", "refactor" ]
                        ]
                    ]
                ]
    , background = Just { url = \images -> images.adventureTime, opacity = 0.3 }
    }
