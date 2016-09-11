module Task.Model exposing (..)


type alias Model =
    { description : String
    , completed : Bool
    , editing : Bool
    , id : Int
    }


newTask : Int -> String -> Model
newTask id description =
    { description = description
    , completed = False
    , editing = False
    , id = id
    }


model : Model
model =
    newTask 1 ""
