module Presentation.Slide3 exposing (..)

import Css
import ElmLogo
import Html.Styled as Html
import Html.Styled.Attributes as Attr
import Presentation.Types
import UI


view : Presentation.Types.Slide msg
view =
    { content =
        \images ->
            Html.div []
                [ Html.div
                    [ [ Css.displayFlex
                      , Css.property "gap" "2rem"
                      , Css.alignItems Css.center
                      ]
                        |> Attr.css
                    ]
                    [ ElmLogo.html 140 |> Html.fromUnstyled
                    , UI.veryBigText "Elm"
                    ]
                , Html.ul []
                    [ Html.li [] [ UI.smallText "Fonctionnel" ]
                    , Html.li [] [ UI.smallText "Minimaliste" ]
                    , Html.li [] [ UI.smallText "Super système de types" ]
                    ]
                ]
    , background = Just <| \images -> images.adventureTime
    }
