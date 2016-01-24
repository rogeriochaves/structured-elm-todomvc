module Model.TaskList where

import Model.Task as Task

type alias Model = List Task.Model

model : Model
model = []
