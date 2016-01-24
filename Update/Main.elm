module Update.Main where

import Action.Main exposing (..)
import Model.Main exposing (Model, initialModel)
import Update.Task as Task
import Update.TaskList as TaskList
import Update.Control as Control

update : Action -> Model -> Model
update action model =
  { model |
      taskEntry = Task.update action model.taskEntry,
      taskList = TaskList.update action model.taskList,
      control = Control.update action model.control
  }

model : Maybe Model -> Signal Model
model getStorage =
  Signal.foldp update (Maybe.withDefault initialModel getStorage) actions.signal
