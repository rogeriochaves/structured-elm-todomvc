module Model.Main where

import Model.TaskList as TaskList
import Update.TaskList exposing (update)
import Model.TaskList exposing (Model)
import Action.Main exposing (actions)

initialModel : Model
initialModel =
  Maybe.withDefault TaskList.model getStorage

model : Signal Model
model =
  Signal.foldp update initialModel actions.signal

port getStorage : Maybe Model
