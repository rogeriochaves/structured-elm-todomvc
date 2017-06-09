module Todo.Msg exposing (..)


type Msg
    = Check Bool
    | Editing Bool
    | Update String
