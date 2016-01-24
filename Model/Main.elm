module Model.Main where

import Model.Task
import Model.TaskList

type alias Model =
  { taskEntry : Model.Task.Model
  , taskList : Model.TaskList.Model
  }

initialModel : Model
initialModel =
  { taskEntry = Model.Task.model
  , taskList = Model.TaskList.model
  }
