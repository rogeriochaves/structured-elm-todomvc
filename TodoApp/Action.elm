module TodoApp.Action where

import Signal exposing (Signal)
import TodoApp.TaskList.Action as TaskList
import TodoApp.Task.Action as Task
import TodoApp.Control.Action as Control

type Action = NoOp
            | ActionForTaskEntry Task.Action
            | ActionForTaskList TaskList.Action
            | ActionForTask Int Task.Action
            | ActionForControl Control.Action

actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp
