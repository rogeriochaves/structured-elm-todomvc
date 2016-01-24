module Action.Main where

import Signal exposing (Signal)
import Action.TaskList as TaskList
import Action.Task as Task
import Action.Control as Control

type Action = NoOp
            | ActionForTaskEntry Task.Action
            | ActionForTaskList TaskList.Action
            | ActionForTask Int Task.Action
            | ActionForControl Control.Action

actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp
