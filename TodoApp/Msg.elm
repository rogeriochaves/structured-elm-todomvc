module TodoApp.Msg exposing (..)

import TodoApp.TaskList.Msg as TaskList
import TodoApp.Task.Msg as Task
import TodoApp.Control.Msg as Control


type Msg
    = NoOp
    | MsgForTaskEntry Task.Msg
    | MsgForTaskList TaskList.Msg
    | MsgForTask Int Task.Msg
    | MsgForControl Control.Msg
