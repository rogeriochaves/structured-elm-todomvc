module View.TaskEntry where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Action.Main as Main exposing (..)
import Action.TaskList exposing (..)
import Action.Task exposing (..)
import Signal exposing (Address)
import View.Events exposing (onEnter)
import Model.Task exposing (Model)

taskEntry : Address Main.Action -> Model -> Html
taskEntry address taskEntry =
    header
      [ id "header" ]
      [ h1 [] [ text "todos" ]
      , input
          [ id "new-todo"
          , placeholder "What needs to be done?"
          , autofocus True
          , value taskEntry.description
          , name "newTodo"
          , on "input" targetValue (Signal.message address << ActionForTaskEntry << Update)
          , onEnter address (ActionForTaskList (Add taskEntry.id taskEntry.description))
          ]
          []
      ]
