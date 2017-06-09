module TodoApp.Msg exposing (..)

import TodoApp.Control as Control
import TodoApp.Task as Task
import TodoApp.TaskList as TaskList


type Msg
    = NoOp
    | MsgForTaskEntry Task.Msg
    | MsgForTaskList TaskList.Msg
    | MsgForControl Control.Msg
