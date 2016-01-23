module Action.Main where

import Signal exposing (Signal)
import Action.TaskList exposing (..)

actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp
