module Presentation.Slides exposing (slides)

import Presentation.Slide1
import Presentation.Slide2
import Presentation.Slide3
import Presentation.Slide4
import Presentation.Slide5
import Presentation.Types


slides : List (Presentation.Types.Slide msg)
slides =
    [ Presentation.Slide1.view
    , Presentation.Slide2.view
    , Presentation.Slide3.view
    , Presentation.Slide4.view
    , Presentation.Slide5.view
    ]
