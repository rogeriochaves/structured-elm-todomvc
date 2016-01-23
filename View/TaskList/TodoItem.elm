module View.TaskList.TodoItem where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Action.Main as Main exposing (..)
import Action.TaskList exposing (..)
import Signal exposing (Address)
import Model.Task as Task
import Json.Decode as Json

onEnter : Address a -> a -> Attribute
onEnter address value =
    on "keydown"
      (Json.customDecoder keyCode is13)
      (\_ -> Signal.message address value)

is13 : Int -> Result String ()
is13 code =
  if code == 13 then Ok () else Err "not the right key code"

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
              , onClick address (ActionForTaskList <| Check todo.id (not todo.completed))
              ]
              []
          , label
              [ onDoubleClick address (ActionForTaskList <| EditingTask todo.id True) ]
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
          , on "input" targetValue (Signal.message address << ActionForTaskList << UpdateTask todo.id)
          , onBlur address (ActionForTaskList <| EditingTask todo.id False)
          , onEnter address (ActionForTaskList <| EditingTask todo.id False)
          ]
          []
      ]
