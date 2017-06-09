module Msg exposing (..)

import Control.Msg as Control
import Todo.Msg as Todo
import TodoList.Msg as TodoList


type Msg
    = NoOp
    | MsgForTodoEntry Todo.Msg
    | MsgForTodoList TodoList.Msg
    | MsgForControl Control.Msg
