module View.Todo.TodoEntry exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Todo as Todo exposing (..)
import View.Todo.Events exposing (onEnter)


todoEntry : Todo.Model -> Html Msg
todoEntry todoEntry =
    header [ id "header" ]
        [ h1 [] [ text "todos" ]
        , input
            [ id "new-todo"
            , placeholder "What needs to be done?"
            , autofocus True
            , value todoEntry.description
            , name "newTodo"
            , on "input" (Json.map Update targetValue)
            , onEnter NoOp (Add todoEntry.id todoEntry.description)
            ]
            []
        ]
