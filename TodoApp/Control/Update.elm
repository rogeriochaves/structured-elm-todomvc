module TodoApp.Control.Update exposing (..)

import TodoApp.Msg as Main exposing (..)
import TodoApp.Control.Msg as Control exposing (..)
import TodoApp.Control.Model exposing (Model)


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
