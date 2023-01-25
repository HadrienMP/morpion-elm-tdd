module UI.Font exposing (m)

import Element


scaled : Int -> Int
scaled =
    Element.modular 12 1.5 >> round


m : Int
m =
    scaled 2
