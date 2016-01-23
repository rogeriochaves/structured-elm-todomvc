module Model.Task where

type alias Model =
    { description : String
    , completed : Bool
    , editing : Bool
    , id : Int
    }

newTask : String -> Int -> Model
newTask desc id =
    { description = desc
    , completed = False
    , editing = False
    , id = id
    }
