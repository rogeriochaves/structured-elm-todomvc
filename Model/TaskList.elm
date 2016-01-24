module Model.TaskList where

import Model.Task as Task

type alias Model =
    { tasks : List Task.Model
    }

model : Model
model =
    { tasks = []
    }
