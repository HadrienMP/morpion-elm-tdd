module Pages.Presentation.S5_Disclaimer exposing (view)

import Element
import Element.Font as Font
import Pages.Presentation.Types
import Pages.Presentation.UI as UI
import Pages.Presentation.UI.Space as Space
import Pages.Presentation.UI.Text as Text


view : Pages.Presentation.Types.Slide msg
view =
    { content =
        \images ->
            Element.row [ Element.spacing Space.l, Element.centerX ]
                [ Element.el [ Element.alignTop ] <|
                    Element.image [ Element.width <| Element.px 140 ]
                        { src = images.disclaimer
                        , description = "Un panneau attention aux tracteurs"
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
    , background = Nothing
    }
