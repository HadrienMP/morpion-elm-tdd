module Pages.Presentation.UI exposing (hr, ol, ul)

import Element
import Element.Border as Border
import Pages.Presentation.UI.Space as Space
import Pages.Presentation.UI.Text as Text


hr : Element.Element msg
hr =
    Element.el [ Border.width 1, Element.width Element.fill ] Element.none


ul : List (Element.Attribute msg) -> List String -> Element.Element msg
ul attributes =
    List.map ((++) "- ")
        >> List.map Text.s
        >> Element.column (Element.spacing Space.xs :: attributes)


ol : List (Element.Attribute msg) -> List String -> Element.Element msg
ol attributes =
    List.indexedMap Tuple.pair
        >> List.map (\( i, el ) -> String.fromInt (i + 1) ++ ". " ++ el)
        >> List.map Text.xs
        >> Element.column (Element.spacing Space.xs :: attributes)
