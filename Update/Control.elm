module Update.Control exposing (..)

import Msg.Main as Main exposing (..)
import Msg.Control as Control exposing (..)
import Model.Control exposing (Model)


update : Main.Msg -> Model -> Model
update actionFor control =
    case actionFor of
        MsgForControl action ->
            updateControl action control

        _ ->
            control


updateControl : Control.Msg -> Model -> Model
updateControl action model =
    case action of
        ChangeVisibility visibility ->
            { model | visibility = visibility }
