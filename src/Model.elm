module Model exposing (..)

import Control.Model
import Todo.Model
import TodoList.Model


type alias Model =
    { todoEntry : Todo.Model.Model
    , todoList : TodoList.Model.Model
    , control : Control.Model.Model
    }


initialModel : Model
initialModel =
    { todoEntry = Todo.Model.model
    , todoList = TodoList.Model.model
    , control = Control.Model.model
    }
