module Model.App exposing (..)

import Model.Control
import Model.Todo
import Model.TodoList


type alias Model =
    { todoEntry : Model.Todo.Model
    , todoList : Model.TodoList.Model
    , control : Model.Control.Model
    }


initialModel : Model
initialModel =
    { todoEntry = Model.Todo.model
    , todoList = Model.TodoList.model
    , control = Model.Control.model
    }
