module TodoApp.View.Task.TaskEntry exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import TodoApp.Task as Task exposing (..)
import TodoApp.View.Task.Events exposing (onEnter)


taskEntry : Task.Model -> Html Msg
taskEntry taskEntry =
    header [ id "header" ]
        [ h1 [] [ text "todos" ]
        , input
            [ id "new-todo"
            , placeholder "What needs to be done?"
            , autofocus True
            , value taskEntry.description
            , name "newTodo"
            , on "input" (Json.map Update targetValue)
            , onEnter NoOp (Add taskEntry.id taskEntry.description)
            ]
            []
        ]
