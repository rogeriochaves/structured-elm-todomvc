module Action.Main where

import Signal exposing (Signal)
import Action.TaskList

type Action = NoOp
            | ActionForTaskList (Action.TaskList.Action)

actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp
