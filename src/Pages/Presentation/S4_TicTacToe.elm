module Pages.Presentation.S4_TicTacToe exposing (view)

import Element
import Element.Font as Font
import Pages.Presentation.Types
import Pages.Presentation.UI as UI
import Pages.Presentation.UI.Space as Space
import Pages.Presentation.UI.Text as Text


view : Pages.Presentation.Types.Slide msg
view =
    { content =
        \images ->
            Element.row [ Element.spacing Space.l, Element.centerX ]
                [ Element.el [ Element.alignTop ] <|
                    Element.image [ Element.width <| Element.px 140 ]
                        { src = images.tictactoe
                        , description = "Une grille de morpion, victoire de X"
                        }
                , Element.column [ Element.spacing Space.m ]
                    [ Text.l2 [ Font.bold ] "Morpion : Règles"
                    , Element.column []
                        [ Text.s2 [ Font.bold ] "Bases"
                        , UI.ul [ Element.moveRight <| toFloat Space.m ]
                            [ "2 joueurs : X et O"
                            , "Grille de 3x3"
                            , "X joue en premier"
                            , "Les joueurs jouent tour à tour"
                            , "On ne pas rejouer sur une case"
                            ]
                        ]
                    , Element.column []
                        [ Text.s2 [ Font.bold ] "Gagner avec 3 coups"
                        , UI.ul [ Element.moveRight <| toFloat Space.m ]
                            [ "en ligne"
                            , "en colonne"
                            , "en diagonale"
                            ]
                        ]
                    , Text.s2 [ Font.bold ] "Égalité si la grille est pleine"
                    ]
                ]
    , background = Nothing
    }
