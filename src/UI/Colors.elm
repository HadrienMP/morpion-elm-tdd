module UI.Colors exposing (accent, background, onBackground)

import Color
import Element
import Element.HexColor exposing (rgbCSSHex)


background : Element.Color
background =
    Color.black |> toElement


onBackground : Element.Color
onBackground =
    Color.white |> toElement


accent : Element.Color
accent =
    rgbCSSHex "#34b2ff"


toElement : Color.Color -> Element.Color
toElement =
    Color.toRgba >> Element.fromRgb
