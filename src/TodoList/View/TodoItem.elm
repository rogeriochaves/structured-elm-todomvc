module TodoList.View.TodoItem exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Msg as Main exposing (..)
import Todo.Model as Todo
import Todo.Msg exposing (..)
import Todo.View.Events exposing (onEnter)
import TodoList.Msg exposing (..)


todoItem : Todo.Model -> Html Main.Msg
todoItem todo =
    li [ classList [ ( "completed", todo.completed ), ( "editing", todo.editing ) ] ]
        [ div [ class "view" ]
            [ input
                [ class "toggle"
                , type_ "checkbox"
                , checked todo.completed
                , onClick (MsgForTodoList <| MsgForTodo todo.id <| Check (not todo.completed))
                ]
                []
            , label [ onDoubleClick (MsgForTodoList <| MsgForTodo todo.id <| Editing True) ]
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
            , on "input" (Json.map (MsgForTodoList << MsgForTodo todo.id << Update) targetValue)
            , onBlur (MsgForTodoList <| MsgForTodo todo.id <| Editing False)
            , onEnter NoOp (MsgForTodoList <| MsgForTodo todo.id <| Editing False)
            ]
            []
        ]
