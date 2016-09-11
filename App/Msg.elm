module App.Msg exposing (..)

import App.TaskList.Msg as TaskList
import App.Task.Msg as Task
import App.Control.Msg as Control


type Msg
    = NoOp
    | MsgForTaskEntry Task.Msg
    | MsgForTaskList TaskList.Msg
    | MsgForTask Int Task.Msg
    | MsgForControl Control.Msg
