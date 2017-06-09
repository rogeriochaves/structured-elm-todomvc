module Todo.View.TodoEntry exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Msg as Main exposing (..)
import Todo.Model exposing (Model)
import Todo.Msg exposing (..)
import Todo.View.Events exposing (onEnter)
import TodoList.Msg exposing (..)


todoEntry : Model -> Html Main.Msg
todoEntry todoEntry =
    header [ id "header" ]
        [ h1 [] [ text "todos" ]
        , input
            [ id "new-todo"
            , placeholder "What needs to be done?"
            , autofocus True
            , value todoEntry.description
            , name "newTodo"
            , on "input" (Json.map (MsgForTodoEntry << Update) targetValue)
            , onEnter NoOp (MsgForTodoList <| Add todoEntry.id todoEntry.description)
            ]
            []
        ]
