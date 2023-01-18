module Presentation.UI.Text exposing (..)

import Element
import Element.Font


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


m : String -> Element.Element msg
m =
    m2 []


m2 : List (Element.Attribute msg) -> String -> Element.Element msg
m2 =
    text 3


l : String -> Element.Element msg
l =
    l2 []


l2 : List (Element.Attribute msg) -> String -> Element.Element msg
l2 =
    text 4


xl : String -> Element.Element msg
xl =
    xl2 []


xl2 : List (Element.Attribute msg) -> String -> Element.Element msg
xl2 =
    text 5


xxl : String -> Element.Element msg
xxl =
    xxl2 []


xxl2 : List (Element.Attribute msg) -> String -> Element.Element msg
xxl2 =
    text 6


text : Int -> List (Element.Attribute msg) -> String -> Element.Element msg
text scale attributes =
    Element.el ((Element.Font.size <| scaled scale) :: attributes) << Element.text
