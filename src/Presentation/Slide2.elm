module Presentation.Slide2 exposing (view)

import Element
import Element.Border as Border
import Element.Font as Font
import Presentation.UI.Sides as Sides
import Presentation.UI.Space as Space
import Presentation.UI.Text as Text


view =
    { content =
        \images ->
            Element.row
                [ Element.spacing Space.xxl
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
    , background = Nothing
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
    Element.column [ Element.alignTop, Element.spacing Space.m ]
        [ Element.image medaillonStyle
            { src = it.image, description = "Une photo de " ++ it.firstName }
        , Element.column [ Element.centerX ]
            [ Text.m2 [ Font.bold, Element.centerX ] it.firstName
            , Text.s2 [ Element.centerX ] it.lastName
            ]
        , Element.column
            [ Element.centerX
            , Sides.init
                |> Sides.withTop 2
                |> Sides.withBottom 2
                |> Border.widthEach
            , Element.paddingXY 0 Space.m
            , Element.spacing Space.xs
            ]
            [ Text.xs2 [ Font.bold, Element.centerX ] it.title1
            , Text.xs2 [ Element.centerX ] it.title2
            ]
        , Element.column [ Element.centerX, Element.spacing Space.xs ]
            [ Element.newTabLink []
                { url = "https://twitter.com/" ++ it.twitter
                , label = Text.xs <| "🐦 @" ++ it.twitter
                }
            , Element.newTabLink []
                { url = "https://" ++ it.website
                , label = Text.xs <| "🌐 " ++ it.website
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
    , Border.rounded 100
    , Border.color <| Element.rgb 1 1 1
    , Border.width 2
    , Element.clip
    , Element.centerX
    ]
