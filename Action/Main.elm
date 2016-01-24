module Action.Main where

import Signal exposing (Signal)
import Action.TaskList
import Action.Task

type Action = NoOp
            | ActionForTaskEntry Action.Task.Action
            | ActionForTask Int Action.Task.Action
            | ActionForTaskList Action.TaskList.Action

actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp
