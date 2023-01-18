module Presentation.Types exposing (..)

import Lib.Slides
import Types exposing (Images)


type alias Slide msg =
    Lib.Slides.Slide Images msg
