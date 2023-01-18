module Presentation.Slide1 exposing (..)

import Css
import ElmLogo
import Html.Styled as Html
import Html.Styled.Attributes as Attr
import Presentation.Types
import UI


view : Presentation.Types.Slide msg
view =
    { content =
        \images ->
            Html.div
                [ [ Css.textAlign Css.center
                  , Css.displayFlex
                  , Css.flexDirection Css.column
                  , Css.property "gap" "3rem"
                  ]
                    |> UI.centerX
                    |> Attr.css
                ]
                [ Html.div [ Attr.css [ Css.minWidth Css.maxContent ] ]
                    [ Html.h1
                        [ Attr.css
                            [ Css.fontSize <| Css.rem 5
                            , Css.lineHeight <| Css.num 1
                            ]
                        ]
                        [ Html.text "Jeu du Morpion" ]
                    , Html.h2
                        [ Attr.css
                            [ Css.fontSize <| Css.rem 2
                            ]
                        ]
                        [ Html.text "Elm + TDD" ]
                    ]
                , Html.div [ Attr.css [ Css.displayFlex, Css.justifyContent Css.spaceBetween ] ]
                    [ Html.img
                        [ Attr.src images.tictactoe
                        , Attr.css [ Css.width <| Css.px 140 ]
                        ]
                        []
                    , Html.fromUnstyled <| ElmLogo.html 140
                    , Html.img
                        [ Attr.src images.tdd
                        , Attr.css
                            [ Css.maxWidth <| Css.px 140
                            , Css.property "object-fit" "cover"
                            ]
                        ]
                        []
                    ]
                ]
    , background = Just <| \images -> images.adventureTime
    }
