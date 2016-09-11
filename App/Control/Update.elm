module Control.Update exposing (..)

import Msg as Main exposing (..)
import Control.Msg as Control exposing (..)
import Control.Model exposing (Model)


update : Main.Msg -> Model -> Model
update msgFor control =
    case msgFor of
        MsgForControl msg ->
            updateControl msg control

        _ ->
            control


updateControl : Control.Msg -> Model -> Model
updateControl msg model =
    case msg of
        ChangeVisibility visibility ->
            { model | visibility = visibility }
