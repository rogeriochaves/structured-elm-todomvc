module TodoApp.Update exposing (..)

import TodoApp.Msg exposing (..)
import TodoApp.Model exposing (Model, initialModel)
import TodoApp.Task.Update as Task
import TodoApp.TaskList.Update as TaskList
import TodoApp.Control.Update as Control


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
  { model
    | taskEntry = Task.update action model.taskEntry
    , taskList = TaskList.update action model.taskList
    , control = Control.update action model.control
  } ! []
