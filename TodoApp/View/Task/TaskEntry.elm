module TodoApp.View.Task.TaskEntry exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import TodoApp.Msg as Main exposing (..)
import TodoApp.Task.Model as Task exposing (Model)
import TodoApp.Task.Msg exposing (..)
import TodoApp.TaskList exposing (..)
import TodoApp.View.Task.Events exposing (onEnter)


taskEntry : Task.Model -> Html Main.Msg
taskEntry taskEntry =
    header [ id "header" ]
        [ h1 [] [ text "todos" ]
        , input
            [ id "new-todo"
            , placeholder "What needs to be done?"
            , autofocus True
            , value taskEntry.description
            , name "newTodo"
            , on "input" (Json.map (MsgForTaskEntry << Update) targetValue)
            , onEnter NoOp (MsgForTaskList <| Add taskEntry.id taskEntry.description)
            ]
            []
        ]
