module Presentation.Slide4 exposing (..)

import Element
import Element.Font
import Presentation.Types
import UI
import UI.Space
import UI.Text


view : Presentation.Types.Slide msg
view =
    { content =
        \images ->
            Element.row [ Element.spacing UI.Space.xLarge, Element.centerX ]
                [ Element.el [ Element.alignTop ] <|
                    Element.image [ Element.width <| Element.px 140 ]
                        { src = images.tictactoe
                        , description = "Une grille de morpion, victoire de X"
                        }
                , Element.column [ Element.spacing UI.Space.large ]
                    [ UI.Text.xLarge2 [ Element.Font.bold ] "Morpion : Règles"
                    , Element.column []
                        [ UI.Text.medium2 [ Element.Font.bold ] "Bases"
                        , UI.ul [ Element.moveRight <| toFloat UI.Space.large ]
                            [ "2 joueurs : X et O"
                            , "Grille de 3x3"
                            , "X joue en premier"
                            , "Les joueurs jouent tour à tour"
                            , "On ne pas rejouer sur une case"
                            ]
                        ]
                    , Element.column []
                        [ UI.Text.medium2 [ Element.Font.bold ] "Gagner avec 3 coups"
                        , UI.ul [ Element.moveRight <| toFloat UI.Space.large ]
                            [ "en ligne"
                            , "en colonne"
                            , "en diagonale"
                            ]
                        ]
                    , UI.Text.medium2 [ Element.Font.bold ] "Égalité si la grille est pleine"
                    ]
                ]
    , background = Just { url = \images -> images.adventureTime, opacity = 0.3 }
    }
