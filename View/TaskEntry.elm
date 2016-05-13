module View.TaskEntry exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msg.Main as Main exposing (..)
import Msg.TaskList exposing (..)
import Msg.Task exposing (..)
import View.Events exposing (onEnter)
import Model.Task exposing (Model)

taskEntry : Model -> Html Main.Msg
taskEntry taskEntry =
    header
      [ id "header" ]
      [ h1 [] [ text "todos" ]
      , input
          [ id "new-todo"
          , placeholder "What needs to be done?"
          , autofocus True
          , value taskEntry.description
          , name "newTodo"
          , onInput (MsgForTaskEntry << Update)
          , onEnter NoOp (MsgForTaskList (Add taskEntry.id taskEntry.description))
          ]
          []
      ]
