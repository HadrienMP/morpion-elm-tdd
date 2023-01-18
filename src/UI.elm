module UI exposing (..)

import Element
import Element.Border
import UI.Space
import UI.Text


hr : Element.Element msg
hr =
    Element.el [ Element.Border.width 1, Element.width Element.fill ] Element.none


ul : List (Element.Attribute msg) -> List String -> Element.Element msg
ul attributes =
    List.map ((++) "- ")
        >> List.map UI.Text.medium
        >> Element.column (Element.spacing UI.Space.small :: attributes)


ol : List (Element.Attribute msg) -> List String -> Element.Element msg
ol attributes =
    List.indexedMap Tuple.pair
        >> List.map (\( i, el ) -> String.fromInt (i + 1) ++ ". " ++ el)
        >> List.map UI.Text.small
        >> Element.column (Element.spacing UI.Space.small :: attributes)
