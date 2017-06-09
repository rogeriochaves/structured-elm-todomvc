module TaskList.Model exposing (..)

import Task.Model as Task


type alias Model =
    List Task.Model


model : Model
model =
    []
