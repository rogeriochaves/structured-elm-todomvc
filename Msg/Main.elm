module Msg.Main exposing (..)

import Msg.TaskList as TaskList
import Msg.Task as Task
import Msg.Control as Control


type Msg
    = NoOp
    | MsgForTaskEntry Task.Msg
    | MsgForTaskList TaskList.Msg
    | MsgForTask Int Task.Msg
    | MsgForControl Control.Msg
