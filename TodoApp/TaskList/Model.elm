module TodoApp.TaskList.Model where

import TodoApp.Task.Model as Task

type alias Model = List Task.Model

model : Model
model = []
