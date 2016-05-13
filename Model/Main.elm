module Model.Main exposing (..)

import Model.Task as Task
import Model.TaskList as TaskList
import Model.Control as Control

type alias Model =
  { taskEntry : Task.Model
  , taskList : TaskList.Model
  , control : Control.Model
  }

initialModel : Model
initialModel =
  { taskEntry = Task.model
  , taskList = TaskList.model
  , control = Control.model
  }

init : Maybe Model -> ( Model, Cmd msg )
init savedModel =
  Maybe.withDefault initialModel savedModel ! []