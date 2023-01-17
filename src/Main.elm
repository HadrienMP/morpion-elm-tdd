module Main exposing (..)

import Browser
import Css
import Dict
import Html as Unstyled
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import Html.Styled.Events as Evts exposing (..)
import Presentation.Library exposing (Slide)
import Presentation.Slides exposing (slides)
import Types exposing (Images)



-- MAIN


type alias Flags =
    { images : Images
    }


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = always Sub.none
        , view = view
        }



-- MODEL


type alias PlayModel =
    ()


type alias PresentationModel =
    { slide : Int
    }


type ModeModel
    = Game PlayModel
    | Presentation (Presentation.Library.Model Images)


type alias Model =
    { images : Images
    , mode : ModeModel
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { mode = Presentation <| Presentation.Library.init flags.images Presentation.Slides.slides
      , images = flags.images
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = PresentationMsg PresentationMsg
    | GameMsg GameMsg


type GameMsg
    = Present


type PresentationMsg
    = SlideMsg Presentation.Library.Msg
    | StartGame


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.mode ) of
        ( PresentationMsg subMsg, Presentation subModel ) ->
            case subMsg of
                StartGame ->
                    ( { model | mode = Game () }, Cmd.none )

                SlideMsg slideMsg ->
                    Presentation.Library.update slideMsg subModel
                        |> Tuple.mapBoth
                            (\updated -> { model | mode = Presentation updated })
                            (Cmd.map <| PresentationMsg << SlideMsg)

        ( GameMsg subMsg, Game subModel ) ->
            case subMsg of
                Present ->
                    ( { model
                        | mode =
                            Presentation <|
                                Presentation.Library.init
                                    model.images
                                    Presentation.Slides.slides
                      }
                    , Cmd.none
                    )

        _ ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Unstyled.Html Msg
view model =
    Html.toUnstyled <|
        Html.div
            [ Attr.css
                [ Css.displayFlex
                , Css.flexDirection Css.column
                , Css.height <| Css.pct 100
                , Css.color <| Css.hex "#fff"
                , Css.backgroundColor <| Css.hex "#000"
                ]
            ]
            [ Html.header [ Attr.css [ Css.backgroundColor <| Css.hex "#000" ] ]
                [ Html.h1 [] [ Html.text "Morpion" ]
                , case model.mode of
                    Presentation _ ->
                        Html.button [ Evts.onClick <| PresentationMsg StartGame ] [ Html.text "Jouer" ]

                    Game _ ->
                        Html.button [ Evts.onClick <| GameMsg Present ] [ Html.text "Présenter" ]
                ]
            , Html.main_
                [ Attr.css
                    [ Css.flexGrow <| Css.int 1
                    , Css.position Css.relative
                    ]
                ]
                [ case model.mode of
                    Presentation presentation ->
                        Presentation.Library.view presentation
                            |> Html.map (PresentationMsg << SlideMsg)

                    Game _ ->
                        Html.h2 [] [ Html.text "Tic Tac Toe" ]
                ]
            ]
