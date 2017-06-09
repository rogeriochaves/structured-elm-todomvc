module Todo.Model exposing (..)


type alias Model =
    { description : String
    , completed : Bool
    , editing : Bool
    , id : Int
    }


newTodo : Int -> String -> Model
newTodo id description =
    { description = description
    , completed = False
    , editing = False
    , id = id
    }


model : Model
model =
    newTodo 1 ""
