module Update.Control where

import Action.Main as Main exposing (..)
import Action.Control as Control exposing (..)
import Model.Control exposing (Model)

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
