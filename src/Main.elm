module Main exposing (..)

import Browser
import Css
import Html as Unstyled
import Html.Styled as Html
import Html.Styled.Attributes as Attr
import Html.Styled.Events as Evts exposing (..)
import Presentation.Library
import Presentation.Slides
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
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias PlayModel =
    ()


type ModeModel
    = Game PlayModel
    | Presentation (Presentation.Library.Model Images)


type alias Model =
    { images : Images
    , mode : ModeModel
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { mode =
            Presentation.Slides.slides
                |> Presentation.Library.init
                |> Presentation
      , images = flags.images
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = PresentationMsg Presentation.Library.Msg
    | SwitchMode


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.mode ) of
        ( SwitchMode, Presentation _ ) ->
            ( { model | mode = Game () }, Cmd.none )

        ( SwitchMode, Game _ ) ->
            ( { model
                | mode =
                    Presentation.Slides.slides
                        |> Presentation.Library.init
                        |> Presentation
              }
            , Cmd.none
            )

        ( PresentationMsg subMsg, Presentation subModel ) ->
            Presentation.Library.update subMsg subModel
                |> Tuple.mapBoth
                    (\updated -> { model | mode = Presentation updated })
                    (Cmd.map <| PresentationMsg)

        _ ->
            ( model, Cmd.none )



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.mode of
        Presentation presentation ->
            Presentation.Library.subscriptions presentation
                |> Sub.map PresentationMsg

        _ ->
            Sub.none



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
                        Html.button [ Evts.onClick SwitchMode ] [ Html.text "Jouer" ]

                    Game _ ->
                        Html.button [ Evts.onClick SwitchMode ] [ Html.text "Présenter" ]
                ]
            , Html.main_
                [ Attr.css
                    [ Css.flexGrow <| Css.int 1
                    , Css.position Css.relative
                    ]
                ]
                [ case model.mode of
                    Presentation presentation ->
                        Presentation.Library.view
                            model.images
                            presentation
                            |> Html.map PresentationMsg

                    Game _ ->
                        Html.h2 [] [ Html.text "Tic Tac Toe" ]
                ]
            ]
