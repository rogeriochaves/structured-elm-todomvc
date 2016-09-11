module TodoApp.TaskList.Model exposing (..)

import TodoApp.Task.Model as Task


type alias Model =
    List Task.Model


model : Model
model =
    []
