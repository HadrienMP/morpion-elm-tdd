module UI.Text exposing (..)

import Element
import Element.Font


scaled : Int -> Int
scaled =
    Element.modular 20 1.4 >> round


small : String -> Element.Element msg
small =
    small2 []


small2 : List (Element.Attribute msg) -> String -> Element.Element msg
small2 =
    text 1


medium : String -> Element.Element msg
medium =
    medium2 []


medium2 : List (Element.Attribute msg) -> String -> Element.Element msg
medium2 =
    text 2


large : String -> Element.Element msg
large =
    large2 []


large2 : List (Element.Attribute msg) -> String -> Element.Element msg
large2 =
    text 3


xLarge : String -> Element.Element msg
xLarge =
    xLarge2 []


xLarge2 : List (Element.Attribute msg) -> String -> Element.Element msg
xLarge2 =
    text 4


giga : String -> Element.Element msg
giga =
    giga2 []


giga2 : List (Element.Attribute msg) -> String -> Element.Element msg
giga2 =
    text 5


xGiga : String -> Element.Element msg
xGiga =
    xGiga2 []


xGiga2 : List (Element.Attribute msg) -> String -> Element.Element msg
xGiga2 =
    text 6


text : Int -> List (Element.Attribute msg) -> String -> Element.Element msg
text scale attributes =
    Element.el ((Element.Font.size <| scaled scale) :: attributes) << Element.text
