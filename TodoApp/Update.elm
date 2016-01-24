module TodoApp.Update where

import TodoApp.Action exposing (..)
import TodoApp.Model exposing (Model, initialModel)
import TodoApp.Task.Update as Task
import TodoApp.TaskList.Update as TaskList
import TodoApp.Control.Update as Control

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
