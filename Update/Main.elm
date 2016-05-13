module Update.Main exposing (..)

import Msg.Main exposing (..)
import Model.Main exposing (Model, initialModel)
import Update.Task as Task
import Update.TaskList as TaskList
import Update.Control as Control

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  { model |
      taskEntry = Task.update msg model.taskEntry,
      taskList = TaskList.update msg model.taskList,
      control = Control.update msg model.control
  } ! []
