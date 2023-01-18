module Presentation.Slide4 exposing (..)

import Element
import Element.Font
import Presentation.Types
import Presentation.UI.Space
import Presentation.UI.Text
import UI


view : Presentation.Types.Slide msg
view =
    { content =
        \images ->
            Element.row [ Element.spacing Presentation.UI.Space.l, Element.centerX ]
                [ Element.el [ Element.alignTop ] <|
                    Element.image [ Element.width <| Element.px 140 ]
                        { src = images.tictactoe
                        , description = "Une grille de morpion, victoire de X"
                        }
                , Element.column [ Element.spacing Presentation.UI.Space.m ]
                    [ Presentation.UI.Text.l2 [ Element.Font.bold ] "Morpion : Règles"
                    , Element.column []
                        [ Presentation.UI.Text.s2 [ Element.Font.bold ] "Bases"
                        , UI.ul [ Element.moveRight <| toFloat Presentation.UI.Space.m ]
                            [ "2 joueurs : X et O"
                            , "Grille de 3x3"
                            , "X joue en premier"
                            , "Les joueurs jouent tour à tour"
                            , "On ne pas rejouer sur une case"
                            ]
                        ]
                    , Element.column []
                        [ Presentation.UI.Text.s2 [ Element.Font.bold ] "Gagner avec 3 coups"
                        , UI.ul [ Element.moveRight <| toFloat Presentation.UI.Space.m ]
                            [ "en ligne"
                            , "en colonne"
                            , "en diagonale"
                            ]
                        ]
                    , Presentation.UI.Text.s2 [ Element.Font.bold ] "Égalité si la grille est pleine"
                    ]
                ]
    , background = Just { url = \images -> images.adventureTime, opacity = 0.3 }
    }
