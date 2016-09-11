module Task.View.TaskEntry exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msg as Main exposing (..)
import TaskList.Msg exposing (..)
import Task.Msg exposing (..)
import Task.View.Events exposing (onEnter)
import Task.Model exposing (Model)
import Json.Decode as Json


taskEntry : Model -> Html Main.Msg
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
