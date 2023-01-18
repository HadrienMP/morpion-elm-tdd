module Presentation.Types exposing (..)

import Presentation.Library
import Types exposing (Images)


type alias Slide msg =
    Presentation.Library.Slide Images msg
