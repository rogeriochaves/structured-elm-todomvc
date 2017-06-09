module Task.View.TaskEntry exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Msg as Main exposing (..)
import Task.Model exposing (Model)
import Task.Msg exposing (..)
import Task.View.Events exposing (onEnter)
import TaskList.Msg exposing (..)


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
