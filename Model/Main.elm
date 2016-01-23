module Model.Main where

import Model.TaskList as TaskList
import Update.TaskList exposing (update)
import Model.TaskList exposing (Model)
import Action.Main exposing (actions)

initialModel : Maybe Model -> Model
initialModel =
  Maybe.withDefault TaskList.model

model : Maybe Model -> Signal Model
model getStorage =
  Signal.foldp update (initialModel getStorage) actions.signal
