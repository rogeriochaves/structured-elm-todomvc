module App.TaskList.Model exposing (..)

import App.Task.Model as Task


type alias Model =
    List Task.Model


model : Model
model =
    []
