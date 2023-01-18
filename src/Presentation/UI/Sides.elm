module Presentation.UI.Sides exposing (..)


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


top : Int -> Sides
top space =
    init |> withTop space


withBottom : Int -> Sides -> Sides
withBottom space sides =
    { sides | bottom = space }


bottom : Int -> Sides
bottom space =
    init |> withBottom space


withLeft : Int -> Sides -> Sides
withLeft space sides =
    { sides | left = space }


left : Int -> Sides
left space =
    init |> withLeft space
