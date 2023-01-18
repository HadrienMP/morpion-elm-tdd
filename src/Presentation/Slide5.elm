module Presentation.Slide5 exposing (view)

import Element
import Element.Font as Font
import Presentation.Types
import Presentation.UI as UI
import Presentation.UI.Space as Space
import Presentation.UI.Text as Text


view : Presentation.Types.Slide msg
view =
    { content =
        \images ->
            Element.row [ Element.spacing Space.l, Element.centerX ]
                [ Element.el [ Element.alignTop ] <|
                    Element.image [ Element.width <| Element.px 140 ]
                        { src = images.disclaimer
                        , description = "Une porte en métal avec trois panneaux d'avertissement: explosif, inflammable, interdit"
                        }
                , Element.column [ Element.spacing Space.m ]
                    [ Text.l2 [ Font.bold ] "Disclaimer"
                    , UI.ul []
                        [ "On finira pas le kata"
                        , "Chorégraphie TDD, pas la vérité"
                        , "Passez outre la bizarrerie du langage"
                        ]
                    ]
                ]
    , background = Just { url = \images -> images.adventureTime, opacity = 0.3 }
    }
