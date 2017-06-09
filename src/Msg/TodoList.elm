module Msg.TodoList exposing (..)

import Msg.Todo as Todo


type Msg
    = Add Int String
    | Delete Int
    | DeleteCompleted
    | CheckAll Bool
    | MsgForTodo Int Todo.Msg
