module UI.Space exposing (m)

import Element


scaled : Int -> Int
scaled =
    Element.modular 6 2 >> round


m : Int
m =
    scaled 3
