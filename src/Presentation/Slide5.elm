module Presentation.Slide5 exposing (..)

import Element
import Element.Font
import Presentation.Types
import UI
import UI.Space
import UI.Text


view : Presentation.Types.Slide msg
view =
    { content =
        \images ->
            Element.row [ Element.spacing UI.Space.xLarge, Element.centerX ]
                [ Element.el [ Element.alignTop ] <|
                    Element.image [ Element.width <| Element.px 140 ]
                        { src = images.disclaimer
                        , description = "Une porte en métal avec trois panneaux d'avertissement: explosif, inflammable, interdit"
                        }
                , Element.column [ Element.spacing UI.Space.large ]
                    [ UI.Text.xLarge2 [ Element.Font.bold ] "Disclaimer"
                    , UI.ul []
                        [ "On finira pas le kata"
                        , "Chorégraphie TDD, pas la vérité"
                        , "Passez outre la bizarrerie du langage"
                        ]
                    ]
                ]
    , background = Just { url = \images -> images.adventureTime, opacity = 0.3 }
    }
