module View.TaskList.TodoItem exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msg.Main as Main exposing (..)
import Msg.Task exposing (..)
import Msg.TaskList exposing (..)
import Model.Task as Task
import View.Events exposing (onEnter)

todoItem : Task.Model -> Html Main.Msg
todoItem todo =
    li
      [ classList [ ("completed", todo.completed), ("editing", todo.editing) ] ]
      [ div
          [ class "view" ]
          [ input
              [ class "toggle"
              , type' "checkbox"
              , checked todo.completed
              , onClick (MsgForTask todo.id <| Check (not todo.completed))
              ]
              []
          , label
              [ onDoubleClick (MsgForTask todo.id <| Editing True) ]
              [ text todo.description ]
          , button
              [ class "destroy"
              , onClick (MsgForTaskList <| Delete todo.id)
              ]
              []
          ]
      , input
          [ class "edit"
          , value todo.description
          , name "title"
          , id ("todo-" ++ toString todo.id)
          , onInput (MsgForTask todo.id << Update)
          , onBlur (MsgForTask todo.id <| Editing False)
          , onEnter NoOp (MsgForTask todo.id <| Editing False)
          ]
          []
      ]
