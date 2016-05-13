module TodoApp.Msg exposing (..)

import TodoApp.Task.Msg as Task
import TodoApp.TaskList.Msg as TaskList
import TodoApp.Control.Msg as Control


type Msg
  = NoOp
  | MsgForTask Int Task.Msg
  | MsgForTaskEntry Task.Msg
  | MsgForTaskList TaskList.Msg
  | MsgForControl Control.Msg
