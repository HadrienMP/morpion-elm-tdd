module Pages.Presentation.UI.Text exposing (l2, m2, s, s2, xl2, xs, xs2, xxl2)

import Element
import Element.Font as Font


scaled : Int -> Int
scaled =
    Element.modular 20 1.4 >> round


xs : String -> Element.Element msg
xs =
    xs2 []


xs2 : List (Element.Attribute msg) -> String -> Element.Element msg
xs2 =
    text 1


s : String -> Element.Element msg
s =
    s2 []


s2 : List (Element.Attribute msg) -> String -> Element.Element msg
s2 =
    text 2


m2 : List (Element.Attribute msg) -> String -> Element.Element msg
m2 =
    text 3


l2 : List (Element.Attribute msg) -> String -> Element.Element msg
l2 =
    text 4


xl2 : List (Element.Attribute msg) -> String -> Element.Element msg
xl2 =
    text 5


xxl2 : List (Element.Attribute msg) -> String -> Element.Element msg
xxl2 =
    text 6


text : Int -> List (Element.Attribute msg) -> String -> Element.Element msg
text scale attributes =
    Element.el ((Font.size <| scaled scale) :: attributes) << Element.text
