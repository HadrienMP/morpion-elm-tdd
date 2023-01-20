module UI.Colors exposing (..)

import Color
import Element


background : Element.Color
background =
    Color.black |> Color.toRgba |> Element.fromRgb


onBackground : Element.Color
onBackground =
    Color.white |> Color.toRgba |> Element.fromRgb
