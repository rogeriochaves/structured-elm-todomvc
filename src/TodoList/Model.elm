module TodoList.Model exposing (..)

import Todo.Model as Todo


type alias Model =
    List Todo.Model


model : Model
model =
    []
