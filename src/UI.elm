module UI exposing (..)

import Element
import Element.Border
import Presentation.UI.Space
import Presentation.UI.Text


hr : Element.Element msg
hr =
    Element.el [ Element.Border.width 1, Element.width Element.fill ] Element.none


ul : List (Element.Attribute msg) -> List String -> Element.Element msg
ul attributes =
    List.map ((++) "- ")
        >> List.map Presentation.UI.Text.s
        >> Element.column (Element.spacing Presentation.UI.Space.xs :: attributes)


ol : List (Element.Attribute msg) -> List String -> Element.Element msg
ol attributes =
    List.indexedMap Tuple.pair
        >> List.map (\( i, el ) -> String.fromInt (i + 1) ++ ". " ++ el)
        >> List.map Presentation.UI.Text.xs
        >> Element.column (Element.spacing Presentation.UI.Space.xs :: attributes)
