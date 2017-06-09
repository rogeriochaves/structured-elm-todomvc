module View.TodoEntry exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Model.Todo exposing (Model)
import Msg.Main as Main exposing (..)
import Msg.Todo exposing (..)
import Msg.TodoList exposing (..)
import View.Events exposing (onEnter)


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
