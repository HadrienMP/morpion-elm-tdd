module Pages.Presentation.Slides exposing (init)

import Lib.Slides
import Pages.Presentation.S1_Title
import Pages.Presentation.S2_Presentation
import Pages.Presentation.S3_ElmTdd
import Pages.Presentation.S4_TicTacToe
import Pages.Presentation.S5_Disclaimer
import Pages.Presentation.Types
import Types
import UI.Colors
import Url


init : Url.Url -> Lib.Slides.Model Types.Images
init url =
    let
        model =
            Lib.Slides.init slides url
    in
    { model
        | background = Nothing
        , accent = UI.Colors.accent
    }


slides : List (Pages.Presentation.Types.Slide msg)
slides =
    [ Pages.Presentation.S1_Title.view
    , Pages.Presentation.S2_Presentation.view
    , Pages.Presentation.S3_ElmTdd.view
    , Pages.Presentation.S4_TicTacToe.view
    , Pages.Presentation.S5_Disclaimer.view
    ]
