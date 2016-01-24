module TodoApp.Control.Update where

import TodoApp.Action as Main exposing (..)
import TodoApp.Control.Action as Control exposing (..)
import TodoApp.Control.Model exposing (Model)

update : Main.Action -> Model -> Model
update actionFor control =
  case actionFor of
    ActionForControl action -> updateControl action control
    _ -> control

updateControl : Control.Action -> Model -> Model
updateControl action model =
    case action of
      ChangeVisibility visibility ->
        { model | visibility = visibility }
