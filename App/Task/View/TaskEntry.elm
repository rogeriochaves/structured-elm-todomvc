module App.Task.View.TaskEntry exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import App.Msg as Main exposing (..)
import App.TaskList.Msg exposing (..)
import App.Task.Msg exposing (..)
import App.Task.View.Events exposing (onEnter)
import App.Task.Model exposing (Model)
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
