module Msg.Main exposing (..)

import Msg.Control as Control
import Msg.Todo as Todo
import Msg.TodoList as TodoList


type Msg
    = NoOp
    | MsgForTodoEntry Todo.Msg
    | MsgForTodoList TodoList.Msg
    | MsgForControl Control.Msg
