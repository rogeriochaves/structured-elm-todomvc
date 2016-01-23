module Model.TaskList where

import Model.Task as Task

type alias Model =
    { tasks : List Task.Model
    , field : String
    , uid : Int
    , visibility : String
    }

model : Model
model =
    { tasks = []
    , visibility = "All"
    , field = ""
    , uid = 0
    }
