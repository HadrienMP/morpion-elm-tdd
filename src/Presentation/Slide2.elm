module Presentation.Slide2 exposing (..)

import Element
import Element.Border
import Element.Font
import Presentation.UI.Sides
import Presentation.UI.Space
import Presentation.UI.Text


view =
    { content =
        \images ->
            Element.row
                [ Element.spacing Presentation.UI.Space.xxl
                , Element.centerX
                ]
                [ profile
                    { image = images.hadrien
                    , firstName = "Hadrien"
                    , lastName = "Mens-Pellen"
                    , title1 = "Freelance"
                    , title2 = "Software Crafter"
                    , twitter = "HadrienMP"
                    , website = "hadrienmp.fr"
                    , logo = Nothing
                    }
                , profile
                    { image = images.thomas
                    , firstName = "Thomas"
                    , lastName = "Carpaye"
                    , title1 = "Confondateur"
                    , title2 = "CTO / Dev"
                    , twitter = "tarcaye"
                    , website = "shodo.io"
                    , logo = Just images.shodo
                    }
                ]
    , background = Just { url = \images -> images.adventureTime, opacity = 0.3 }
    }


profile :
    { image : String
    , firstName : String
    , lastName : String
    , title1 : String
    , title2 : String
    , twitter : String
    , website : String
    , logo : Maybe String
    }
    -> Element.Element msg
profile it =
    Element.column [ Element.alignTop, Element.spacing Presentation.UI.Space.m ]
        [ Element.image medaillonStyle
            { src = it.image, description = "Une photo de " ++ it.firstName }
        , Element.column [ Element.centerX ]
            [ Presentation.UI.Text.m2 [ Element.Font.bold, Element.centerX ] it.firstName
            , Presentation.UI.Text.s2 [ Element.centerX ] it.lastName
            ]
        , Element.column
            [ Element.centerX
            , Presentation.UI.Sides.init
                |> Presentation.UI.Sides.withTop 2
                |> Presentation.UI.Sides.withBottom 2
                |> Element.Border.widthEach
            , Element.paddingXY 0 Presentation.UI.Space.m
            , Element.spacing Presentation.UI.Space.xs
            ]
            [ Presentation.UI.Text.xs2 [ Element.Font.bold, Element.centerX ] it.title1
            , Presentation.UI.Text.xs2 [ Element.centerX ] it.title2
            ]
        , Element.column [ Element.centerX, Element.spacing Presentation.UI.Space.xs ]
            [ Element.newTabLink []
                { url = "https://twitter.com/" ++ it.twitter
                , label = Presentation.UI.Text.xs <| "🐦 @" ++ it.twitter
                }
            , Element.newTabLink []
                { url = "https://" ++ it.website
                , label = Presentation.UI.Text.xs <| "🌐 " ++ it.website
                }
            ]
        , it.logo
            |> Maybe.map (\a -> Element.image medaillonStyle { src = a, description = "" })
            |> Maybe.withDefault Element.none
        ]


medaillonStyle : List (Element.Attribute msg)
medaillonStyle =
    [ Element.width <| Element.px 140
    , Element.height <| Element.px 140
    , Element.Border.rounded 100
    , Element.Border.color <| Element.rgb 1 1 1
    , Element.Border.width 2
    , Element.clip
    , Element.centerX
    ]
