module Main exposing (Flags, ModeModel(..), Model, Msg(..), main)

import Browser
import Browser.Events
import Browser.Navigation
import Element
import Element.Background as Background
import Element.Font as Font
import Element.Region
import Lib.Slides
import Pages.Game
import Pages.Presentation.Slides
import Routes
import Shared
import Types exposing (Images)
import UI.Colors
import UI.Font
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


type ModeModel
    = Game Pages.Game.Model
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
            Game <| Pages.Game.init

        Routes.Presentation ->
            Pages.Presentation.Slides.init url |> Presentation



-- UPDATE


type Msg
    = PresentationMsg Lib.Slides.Msg
    | GameMsg Pages.Game.Msg
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

        ( GameMsg subMsg, Game subModel ) ->
            Pages.Game.update subMsg subModel
                |> Tuple.mapBoth
                    (\updated -> { model | mode = Game updated })
                    (Cmd.map <| GameMsg)

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
            , Font.size UI.Font.m
            ]
          <|
            Element.column
                [ Element.height Element.fill
                , Element.width Element.fill
                , Element.behindContent <|
                    Element.el
                        [ Background.image model.images.adventureTime
                        , Element.width Element.fill
                        , Element.height Element.fill
                        , Element.alpha 0.3
                        ]
                    <|
                        Element.none
                ]
                [ navigation model
                , mainContent model
                ]
        ]
    }


navigation : Model -> Element.Element Msg
navigation model =
    Element.row
        [ Element.Region.navigation, Element.padding UI.Space.m, Element.spacing UI.Space.m ]
        ((Element.image
            [ Element.width <| Element.px 50
            ]
          <|
            { src = model.images.tictactoe, description = "une grille de morpion" }
         )
            :: (Routes.nav
                    |> List.map
                        (\route ->
                            Element.link
                                (if routeOf model.mode == route then
                                    [ Font.color UI.Colors.accent, Font.bold ]

                                 else
                                    [ Font.extraLight ]
                                )
                                { url = Routes.stringUrl route
                                , label = Element.text <| Routes.humanName route
                                }
                        )
               )
        )


routeOf : ModeModel -> Routes.Route
routeOf mode =
    case mode of
        Game _ ->
            Routes.Game

        Presentation _ ->
            Routes.Presentation


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
                    (mainContentSize model.windowSize)
                    model.images
                    presentation
                    |> Element.html
                    |> Element.map PresentationMsg

            Game game ->
                Pages.Game.view
                    model.images
                    { width = model.windowSize.width
                    , height = model.windowSize.height - 100
                    }
                    game
                    |> Element.map GameMsg


mainContentSize : Types.Size -> Types.Size
mainContentSize windowSize =
    { width = windowSize.width
    , height = windowSize.height - 68
    }
