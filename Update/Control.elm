module Update.Control exposing (..)

import Msg.Main as Main exposing (..)
import Msg.Control as Control exposing (..)
import Model.Control exposing (Model)

update : Main.Msg -> Model -> Model
update msgFor control =
  case msgFor of
    MsgForControl msg -> updateControl msg control
    _ -> control

updateControl : Control.Msg -> Model -> Model
updateControl msg model =
    case msg of
      ChangeVisibility visibility ->
        { model | visibility = visibility }
