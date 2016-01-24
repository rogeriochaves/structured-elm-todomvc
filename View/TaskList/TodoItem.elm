module View.TaskList.TodoItem where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Action.Main as Main exposing (..)
import Action.Task exposing (..)
import Action.TaskList exposing (..)
import Signal exposing (Address)
import Model.Task as Task
import View.Events exposing (onEnter)

todoItem : Address Main.Action -> Task.Model -> Html
todoItem address todo =
    li
      [ classList [ ("completed", todo.completed), ("editing", todo.editing) ] ]
      [ div
          [ class "view" ]
          [ input
              [ class "toggle"
              , type' "checkbox"
              , checked todo.completed
              , onClick address (ActionForTask todo.id <| Check (not todo.completed))
              ]
              []
          , label
              [ onDoubleClick address (ActionForTask todo.id <| Editing True) ]
              [ text todo.description ]
          , button
              [ class "destroy"
              , onClick address (ActionForTaskList <| Delete todo.id)
              ]
              []
          ]
      , input
          [ class "edit"
          , value todo.description
          , name "title"
          , id ("todo-" ++ toString todo.id)
          , on "input" targetValue (Signal.message address << ActionForTask todo.id << Update)
          , onBlur address (ActionForTask todo.id <| Editing False)
          , onEnter address (ActionForTask todo.id <| Editing False)
          ]
          []
      ]
