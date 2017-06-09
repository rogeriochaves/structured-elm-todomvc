module TodoList.Msg exposing (..)

import Todo.Msg as Todo


type Msg
    = Add Int String
    | Delete Int
    | DeleteCompleted
    | CheckAll Bool
    | MsgForTodo Int Todo.Msg
