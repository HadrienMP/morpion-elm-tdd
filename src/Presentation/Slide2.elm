module Presentation.Slide2 exposing (..)

import Element
import Element.Border
import Element.Font
import UI.Sides
import UI.Space
import UI.Text


view =
    { content =
        \images ->
            Element.row
                [ Element.spacing UI.Space.xxxLarge
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
    , background = Just <| \images -> images.adventureTime
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
    Element.column [ Element.alignTop, Element.spacing UI.Space.large ]
        [ Element.image medaillonStyle
            { src = it.image, description = "Une photo de " ++ it.firstName }
        , Element.column [ Element.centerX ]
            [ UI.Text.large2 [ Element.Font.bold, Element.centerX ] it.firstName
            , UI.Text.medium2 [ Element.centerX ] it.lastName
            ]
        , Element.column
            [ Element.centerX
            , UI.Sides.init
                |> UI.Sides.withTop 2
                |> UI.Sides.withBottom 2
                |> Element.Border.widthEach
            , Element.paddingXY 0 UI.Space.large
            , Element.spacing UI.Space.small
            ]
            [ UI.Text.small2 [ Element.Font.bold, Element.centerX ] it.title1
            , UI.Text.small2 [ Element.centerX ] it.title2
            ]
        , Element.column [ Element.centerX, Element.spacing UI.Space.small ]
            [ Element.link []
                { url = "https://twitter.com/" ++ it.twitter
                , label = UI.Text.small <| "🐦 @" ++ it.twitter
                }
            , Element.link []
                { url = "https://" ++ it.website
                , label = UI.Text.small <| "🌐 " ++ it.website
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
