module Model.Main where

import Model.TaskList as TaskList

type alias Model =
  { taskList : TaskList.Model
  }

model : Model
model =
  { taskList = TaskList.model
  }
