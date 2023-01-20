module Shared exposing (..)

import Browser
import Browser.Navigation exposing (Key)
import Url exposing (Url)



-- Init


type alias Shared =
    { url : Url
    , key : Key
    }



-- Update


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Shared -> ( Shared, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Browser.Navigation.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Browser.Navigation.load href )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )
