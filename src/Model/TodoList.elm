module Model.TodoList exposing (..)

import Model.Todo as Todo


type alias Model =
    List Todo.Model


model : Model
model =
    []
