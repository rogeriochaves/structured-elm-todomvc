module TodoApp.Model where

import TodoApp.Task.Model as Task
import TodoApp.TaskList.Model as TaskList
import TodoApp.Control.Model as Control

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
