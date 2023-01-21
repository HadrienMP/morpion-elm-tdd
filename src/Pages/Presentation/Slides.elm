module Pages.Presentation.Slides exposing (init)

import Lib.Slides
import Pages.Presentation.Slide1
import Pages.Presentation.Slide2
import Pages.Presentation.Slide3
import Pages.Presentation.Slide4
import Pages.Presentation.Slide5
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
        | background = Lib.Slides.Image { url = .adventureTime, opacity = 0.3 }
        , accent = UI.Colors.accent
    }


slides : List (Pages.Presentation.Types.Slide msg)
slides =
    [ Pages.Presentation.Slide1.view
    , Pages.Presentation.Slide2.view
    , Pages.Presentation.Slide3.view
    , Pages.Presentation.Slide4.view
    , Pages.Presentation.Slide5.view
    ]
