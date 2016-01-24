module Update.Main where

import Action.Main exposing (..)
import Model.Main exposing (Model, initialModel)
import Update.Task
import Update.TaskList

update : Action -> Model -> Model
update action model =
  { model |
      taskEntry = Update.Task.update action model.taskEntry,
      taskList = Update.TaskList.update action model.taskList
  }

model : Maybe Model -> Signal Model
model getStorage =
  Signal.foldp update (Maybe.withDefault initialModel getStorage) actions.signal
