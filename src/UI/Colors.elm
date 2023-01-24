module UI.Colors exposing (accent, background, darken, onAccent, onBackground, withAlpha)

import Color
import Element
import Element.HexColor exposing (rgbCSSHex)



-- Palette


background : Element.Color
background =
    Color.black |> toElement


onBackground : Element.Color
onBackground =
    Color.white |> toElement


accent : Element.Color
accent =
    rgbCSSHex "#f2c92f"


onAccent : Element.Color
onAccent =
    rgbCSSHex "#000"



-- Functions


toElement : Color.Color -> Element.Color
toElement =
    Color.toRgba >> Element.fromRgb


darken : Int -> Element.Color -> Element.Color
darken factor =
    Element.toRgb
        >> Color.fromRgba
        >> Color.toHsla
        >> (\color -> { color | lightness = color.lightness * (1 - toFloat factor / 100) })
        >> Color.fromHsla
        >> toElement


withAlpha : Float -> Element.Color -> Element.Color
withAlpha alpha =
    Element.toRgb
        >> (\color -> { color | alpha = alpha })
        >> Element.fromRgb
