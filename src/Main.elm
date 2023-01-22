module Main exposing (Flags, ModeModel(..), Model, Msg(..), PlayModel, main)

import Browser
import Browser.Events
import Browser.Navigation
import Element
import Element.Background as Background
import Element.Font as Font
import Element.Region
import Lib.Slides
import Pages.Presentation.Slides
import Routes
import Shared
import Types exposing (Images)
import UI.Colors
import UI.Space
import Url



-- MAIN


type alias Flags =
    { images : Images
    , windowSize : Types.Size
    }


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        , onUrlChange = SharedMsg << Shared.UrlChanged
        , onUrlRequest = SharedMsg << Shared.LinkClicked
        }



-- MODEL


type alias PlayModel =
    ()


type ModeModel
    = Game PlayModel
    | Presentation (Lib.Slides.Model Images)


type alias Model =
    { images : Images
    , windowSize : Types.Size
    , mode : ModeModel
    , shared : Shared.Shared
    }


init : Flags -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    ( { mode = initMode url
      , images = flags.images
      , windowSize = flags.windowSize
      , shared =
            { url = url
            , key = key
            }
      }
    , Cmd.none
    )


initMode : Url.Url -> ModeModel
initMode url =
    case Routes.parse url of
        Routes.Game ->
            Game ()

        Routes.Presentation ->
            Pages.Presentation.Slides.init url |> Presentation



-- UPDATE


type Msg
    = PresentationMsg Lib.Slides.Msg
    | SharedMsg Shared.Msg
    | Resized Types.Size


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.mode ) of
        ( PresentationMsg subMsg, Presentation subModel ) ->
            Lib.Slides.update model.shared.key subMsg subModel
                |> Tuple.mapBoth
                    (\updated -> { model | mode = Presentation updated })
                    (Cmd.map <| PresentationMsg)

        ( SharedMsg subMsg, _ ) ->
            Shared.update subMsg model.shared
                |> Tuple.mapBoth
                    (\next ->
                        { model
                            | shared = next
                            , mode = initMode next.url
                        }
                    )
                    (Cmd.map SharedMsg)

        ( Resized newSize, _ ) ->
            ( { model | windowSize = newSize }, Cmd.none )

        _ ->
            ( model, Cmd.none )



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Browser.Events.onResize (\width height -> Resized { width = width, height = height })
        , case model.mode of
            Presentation presentation ->
                Lib.Slides.subscriptions presentation
                    |> Sub.map PresentationMsg

            _ ->
                Sub.none
        ]



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "Morpion"
    , body =
        [ Element.layoutWith
            { options =
                [ Element.focusStyle
                    { borderColor = Nothing
                    , backgroundColor = Nothing
                    , shadow = Nothing
                    }
                ]
            }
            [ Background.color UI.Colors.background
            , Font.color UI.Colors.onBackground
            ]
          <|
            Element.column
                [ Element.height Element.fill
                , Element.width Element.fill
                ]
                [ navigation
                , mainContent model
                ]
        ]
    }


navigation : Element.Element Msg
navigation =
    Element.row
        [ Element.Region.navigation, Element.padding UI.Space.m, Element.spacing UI.Space.m ]
        [ Element.el [ Element.Region.heading 1, Font.bold ] <| Element.text "Morpion"
        , Element.link
            [ Font.color UI.Colors.accent
            ]
            { url = Routes.Game |> Routes.toString, label = Element.text "Jouer" }
        , Element.link
            [ Font.color UI.Colors.accent
            ]
            { url = Routes.Presentation |> Routes.toString, label = Element.text "Présenter" }
        ]


mainContent : Model -> Element.Element Msg
mainContent model =
    Element.el
        [ Element.Region.mainContent
        , Element.height Element.fill
        , Element.width Element.fill
        , Element.clip
        ]
    <|
        case model.mode of
            Presentation presentation ->
                Lib.Slides.view
                    { width = model.windowSize.width
                    , height = model.windowSize.height - 68
                    }
                    model.images
                    presentation
                    |> Element.html
                    |> Element.map PresentationMsg

            Game _ ->
                Element.text "Game"
