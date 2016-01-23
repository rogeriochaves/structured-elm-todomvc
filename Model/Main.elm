module Model.Main where

import Model.TaskList as TaskList
import Model.TaskList

type alias Model =
  { taskList : Model.TaskList.Model
  }

initialModel : Model
initialModel =
  { taskList = Model.TaskList.model
  }
