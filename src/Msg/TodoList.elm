module Msg.TodoList exposing (..)


type Msg
    = Add Int String
    | Delete Int
    | DeleteCompleted
    | CheckAll Bool
