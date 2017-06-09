module Msg.Main exposing (..)

import Msg.Control as Control
import Msg.Task as Task
import Msg.TaskList as TaskList


type Msg
    = NoOp
    | MsgForTaskEntry Task.Msg
    | MsgForTaskList TaskList.Msg
    | MsgForTask Int Task.Msg
    | MsgForControl Control.Msg
