module Presentation.Slides exposing (..)

import Presentation.Library exposing (Slide)
import Presentation.Slide1
import Presentation.Slide2
import Presentation.Slide3
import Presentation.Types


type alias Slide msg =
    Presentation.Types.Slide msg


slides : List (Slide msg)
slides =
    [ Presentation.Slide1.view
    , Presentation.Slide2.view
    , Presentation.Slide3.view
    ]
