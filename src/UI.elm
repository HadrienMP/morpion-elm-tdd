module UI exposing (..)

import Css


center : List Css.Style -> List Css.Style
center other =
    other
        ++ [ Css.position Css.absolute
           , Css.top <| Css.pct 50
           , Css.left <| Css.vw 50
           , Css.transform <| Css.translate2 (Css.pct -50) (Css.pct -50)
           ]
