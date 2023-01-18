module Presentation.Types exposing (Slide)

import Lib.Slides
import Types exposing (Images)


type alias Slide msg =
    Lib.Slides.Slide Images msg
