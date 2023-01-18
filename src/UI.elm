module UI exposing (..)

import Css
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr


center : List Css.Style -> List Css.Style
center other =
    other
        ++ [ Css.position Css.absolute
           , Css.top <| Css.pct 50
           , Css.left <| Css.pct 50
           , Css.transform <| Css.translate2 (Css.pct -50) (Css.pct -50)
           ]


centerX : List Css.Style -> List Css.Style
centerX other =
    other ++ [ Css.margin Css.auto, Css.maxWidth Css.fitContent ]


veryBigText : String -> Html msg
veryBigText =
    text (Css.rem 5)


bigText : String -> Html msg
bigText =
    text (Css.rem 3)


mediumText : String -> Html msg
mediumText =
    text (Css.rem 2)


smallText : String -> Html msg
smallText =
    text (Css.rem 1)


text : Css.Rem -> String -> Html msg
text size value =
    Html.p [ Attr.css [ Css.fontSize size ] ] [ Html.text value ]
