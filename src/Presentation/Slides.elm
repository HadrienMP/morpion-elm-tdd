module Presentation.Slides exposing (init, slides)

import Lib.Slides
import Presentation.Slide1
import Presentation.Slide2
import Presentation.Slide3
import Presentation.Slide4
import Presentation.Slide5
import Presentation.Types
import Types


init : Lib.Slides.Model Types.Images
init =
    let
        model =
            Lib.Slides.init slides
    in
    { model | background = Lib.Slides.Image { url = .adventureTime, opacity = 0.3 } }


slides : List (Presentation.Types.Slide msg)
slides =
    [ Presentation.Slide1.view
    , Presentation.Slide2.view
    , Presentation.Slide3.view
    , Presentation.Slide4.view
    , Presentation.Slide5.view
    ]
