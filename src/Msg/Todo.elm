module Msg.Todo exposing (..)


type Msg
    = Check Bool
    | Editing Bool
    | Update String
