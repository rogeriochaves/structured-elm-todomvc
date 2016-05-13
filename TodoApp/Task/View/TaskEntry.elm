module TodoApp.Task.View.TaskEntry exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import TodoApp.Msg as Main exposing (..)
import TodoApp.TaskList.Msg exposing (..)
import TodoApp.Task.Msg exposing (..)
import TodoApp.Task.View.Events exposing (onEnter)
import TodoApp.Task.Model exposing (Model)


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
