module UI.Space exposing (..)

import Element


scaled : Int -> Int
scaled =
    Element.modular 6 2 >> round


small : Int
small =
    scaled 1


medium : Int
medium =
    scaled 2


large : Int
large =
    scaled 3


xLarge : Int
xLarge =
    scaled 4


xxLarge : Int
xxLarge =
    scaled 5


xxxLarge : Int
xxxLarge =
    scaled 6
