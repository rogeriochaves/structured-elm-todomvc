module View.TaskEntry where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Action.Main as Main exposing (..)
import Action.TaskList exposing (..)
import Signal exposing (Address)
import View.Events exposing (onEnter)

taskEntry : Address Main.Action -> String -> Html
taskEntry address task =
    header
      [ id "header" ]
      [ h1 [] [ text "todos" ]
      , input
          [ id "new-todo"
          , placeholder "What needs to be done?"
          , autofocus True
          , value task
          , name "newTodo"
          , on "input" targetValue (Signal.message address << ActionForTaskList << UpdateField)
          , onEnter address (ActionForTaskList Add)
          ]
          []
      ]
