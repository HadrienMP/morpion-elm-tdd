module Presentation.Slide2 exposing (..)

import Css
import ElmLogo
import Html.Styled as Html
import Html.Styled.Attributes as Attr
import Presentation.Library exposing (Slide)
import Presentation.Slide1
import Presentation.Types
import Types exposing (Images)
import UI


view =
    { content =
        \images ->
            Html.div
                [ Attr.css
                    [ Css.displayFlex
                    , Css.justifyContent Css.spaceAround
                    ]
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
    -> Html.Html msg
profile it =
    Html.div
        [ Attr.css
            [ Css.textAlign Css.center
            , Css.displayFlex
            , Css.flexDirection Css.column
            , Css.property "gap" "1rem"
            , Css.fontSize <| Css.rem 1.3
            ]
        ]
        [ Html.img
            [ Attr.src it.image
            , Attr.css
                [ Css.width <| Css.rem 10
                , Css.borderRadius <| Css.pct 50
                , Css.border3 (Css.px 2) Css.solid <| Css.hex "#fff"
                , Css.height <| Css.rem 10
                , Css.marginBottom <| Css.rem 1
                ]
            ]
            []
        , Html.div []
            [ Html.h2 [ Attr.css [ Css.fontSize <| Css.rem 3 ] ] [ Html.text it.firstName ]
            , Html.h3 [ Attr.css [ Css.fontSize <| Css.rem 2 ] ] [ Html.text it.lastName ]
            ]
        , Html.hr [ Attr.css [ Css.width <| Css.pct 100 ] ] []
        , Html.div []
            [ Html.p [ Attr.css [ Css.fontSize <| Css.rem 1.6 ] ] [ Html.text it.title1 ]
            , Html.p [] [ Html.text it.title2 ]
            ]
        , Html.hr [ Attr.css [ Css.width <| Css.pct 100 ] ] []
        , Html.div
            [ Attr.css
                [ Css.color <| Css.hex "#63c4ff"
                , Css.displayFlex
                , Css.flexDirection Css.column
                ]
            ]
            [ Html.a
                [ Attr.href <| "https://twitter.com/" ++ it.twitter
                , Attr.target "blank"
                ]
                [ Html.text <| "🐦 @" ++ it.twitter ]
            , Html.a
                [ Attr.href <| "https://" ++ it.website
                , Attr.target "blank"
                ]
                [ Html.text <| "🌐 " ++ it.website ]
            ]
        , case it.logo of
            Just logo ->
                Html.img
                    [ Attr.src logo
                    , Attr.css
                        [ Css.borderRadius <| Css.pct 50
                        , Css.width <| Css.rem 8
                        , Css.margin2 Css.zero Css.auto
                        , Css.marginTop <| Css.rem 2
                        ]
                    ]
                    []

            Nothing ->
                Html.div [] []
        ]
