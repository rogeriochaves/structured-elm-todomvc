module Model.TaskList where

import Model.Task as Task

type alias Model =
    { tasks : List Task.Model
    , visibility : String
    }

model : Model
model =
    { tasks = []
    , visibility = "All"
    }
