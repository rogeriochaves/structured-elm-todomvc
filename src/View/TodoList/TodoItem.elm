module View.TodoList.TodoItem exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Model.Todo as Todo
import Msg.Main as Main exposing (..)
import Msg.Todo exposing (..)
import Msg.TodoList exposing (..)
import View.Events exposing (onEnter)


todoItem : Todo.Model -> Html Main.Msg
todoItem todo =
    li [ classList [ ( "completed", todo.completed ), ( "editing", todo.editing ) ] ]
        [ div [ class "view" ]
            [ input
                [ class "toggle"
                , type_ "checkbox"
                , checked todo.completed
                , onClick (MsgForTodo todo.id <| Check (not todo.completed))
                ]
                []
            , label [ onDoubleClick (MsgForTodo todo.id <| Editing True) ]
                [ text todo.description ]
            , button
                [ class "destroy"
                , onClick (MsgForTodoList <| Delete todo.id)
                ]
                []
            ]
        , input
            [ class "edit"
            , value todo.description
            , name "title"
            , id ("todo-" ++ toString todo.id)
            , on "input" (Json.map (MsgForTodo todo.id << Update) targetValue)
            , onBlur (MsgForTodo todo.id <| Editing False)
            , onEnter NoOp (MsgForTodo todo.id <| Editing False)
            ]
            []
        ]
