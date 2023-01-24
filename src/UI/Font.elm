module UI.Font exposing (..)

import Element


scaled : Int -> Int
scaled =
    Element.modular 12 1.5 >> round


m : Int
m =
    scaled 2


l : Int
l =
    scaled 3
