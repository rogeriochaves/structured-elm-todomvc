module Todo where

import Html exposing (..)
import Signal exposing (Signal, Address)
import Action.TaskList exposing (..)
import Model.TaskList as TaskList exposing (Model)
import View.Main exposing (view)
import Action.Main exposing (actions)
import Model.Main exposing (model)

main : Signal Html
main =
  Signal.map (view actions.address) model

port focus : Signal String
port focus =
    let needsFocus act =
            case act of
              EditingTask id bool -> bool
              _ -> False

        toSelector act =
            case act of
              EditingTask id _ -> "#todo-" ++ toString id
              _ -> ""
    in
        actions.signal
          |> Signal.filter needsFocus (EditingTask 0 True)
          |> Signal.map toSelector

port setStorage : Signal Model
port setStorage = model
