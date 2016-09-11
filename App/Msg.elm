module Msg exposing (..)

import TaskList.Msg as TaskList
import Task.Msg as Task
import Control.Msg as Control


type Msg
    = NoOp
    | MsgForTaskEntry Task.Msg
    | MsgForTaskList TaskList.Msg
    | MsgForTask Int Task.Msg
    | MsgForControl Control.Msg
