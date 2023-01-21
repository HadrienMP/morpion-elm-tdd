module Pages.Presentation.Slide3 exposing (view)

import Element
import Element.Font as Font
import ElmLogo
import Pages.Presentation.Types
import Pages.Presentation.UI as UI
import Pages.Presentation.UI.Space as Space
import Pages.Presentation.UI.Text as Text


view : Pages.Presentation.Types.Slide msg
view =
    { content =
        \images ->
            Element.column [ Element.centerX, Element.spacing Space.l ]
                [ Element.row [ Element.spacing Space.l ]
                    [ Element.el [ Element.alignTop ] <| ElmLogo.element 140
                    , Element.column [ Element.spacing Space.s ]
                        [ Text.l2 [ Font.bold ] "Elm"
                        , UI.ul []
                            [ "Evan Czaplicki : 2012"
                            , "Frontend"
                            , "Fonctionnel"
                            , "Minimaliste"
                            , "Super système de types"
                            ]
                        ]
                    ]
                , UI.hr
                , Element.row [ Element.spacing Space.l ]
                    [ Element.el [ Element.alignTop ] <|
                        Element.image
                            [ Element.width <| Element.px 140
                            , Element.height <| Element.px 140
                            ]
                            { src = images.tdd
                            , description = "Le cycle TDD: Red Green Refactor"
                            }
                    , Element.column [ Element.spacing Space.s ]
                        [ Text.l2 [ Font.bold ] "TDD"
                        , UI.ul []
                            [ "Kent Beck : 1999"
                            , "Technique de design"
                            , "Cycle :"
                            ]
                        , UI.ol [ Element.moveRight <| toFloat Space.l ] [ "1 test simple", "correction évidente/anarque", "refactor" ]
                        ]
                    ]
                ]
    , background = Nothing
    }
