module TodoApp.Msg exposing (..)

import TodoApp.Control.Msg as Control
import TodoApp.Task.Msg as Task
import TodoApp.TaskList.Msg as TaskList


type Msg
    = NoOp
    | MsgForTaskEntry Task.Msg
    | MsgForTaskList TaskList.Msg
    | MsgForTask Int Task.Msg
    | MsgForControl Control.Msg
