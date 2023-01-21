module Pages.Presentation.UI.Sides exposing (Sides, init, withBottom, withTop)


type alias Sides =
    { top : Int
    , right : Int
    , bottom : Int
    , left : Int
    }


init : Sides
init =
    { top = 0, right = 0, bottom = 0, left = 0 }


withTop : Int -> Sides -> Sides
withTop space sides =
    { sides | top = space }


withBottom : Int -> Sides -> Sides
withBottom space sides =
    { sides | bottom = space }
