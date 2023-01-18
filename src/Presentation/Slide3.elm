module Presentation.Slide3 exposing (..)

import Element
import Element.Font
import ElmLogo
import Presentation.Types
import Presentation.UI.Space
import Presentation.UI.Text
import UI


view : Presentation.Types.Slide msg
view =
    { content =
        \images ->
            Element.column [ Element.centerX, Element.spacing Presentation.UI.Space.l ]
                [ Element.row [ Element.spacing Presentation.UI.Space.l ]
                    [ Element.el [ Element.alignTop ] <| ElmLogo.element 140
                    , Element.column [ Element.spacing Presentation.UI.Space.s ]
                        [ Presentation.UI.Text.l2 [ Element.Font.bold ] "Elm"
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
                , Element.row [ Element.spacing Presentation.UI.Space.l ]
                    [ Element.el [ Element.alignTop ] <|
                        Element.image
                            [ Element.width <| Element.px 140
                            , Element.height <| Element.px 140
                            ]
                            { src = images.tdd
                            , description = "Le cycle TDD: Red Green Refactor"
                            }
                    , Element.column [ Element.spacing Presentation.UI.Space.s ]
                        [ Presentation.UI.Text.l2 [ Element.Font.bold ] "TDD"
                        , UI.ul []
                            [ "Kent Beck : 1999"
                            , "Technique de design"
                            , "Cycle :"
                            ]
                        , UI.ol [ Element.moveRight <| toFloat Presentation.UI.Space.l ] [ "1 test simple", "correction évidente/anarque", "refactor" ]
                        ]
                    ]
                ]
    , background = Just { url = \images -> images.adventureTime, opacity = 0.3 }
    }
