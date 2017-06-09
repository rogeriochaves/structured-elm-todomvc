module TodoList.View.TodoList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msg as Main exposing (..)
import Todo.Model as Todo
import Todo.View.TodoItem exposing (todoItem)
import TodoList.Msg exposing (..)


todoList : String -> List Todo.Model -> Html Main.Msg
todoList visibility todos =
    let
        isVisible todo =
            case visibility of
                "Completed" ->
                    todo.completed

                "Active" ->
                    not todo.completed

                _ ->
                    True

        allCompleted =
            List.all .completed todos

        cssVisibility =
            if List.isEmpty todos then
                "hidden"
            else
                "visible"
    in
    section
        [ id "main"
        , style [ ( "visibility", cssVisibility ) ]
        ]
        [ input
            [ id "toggle-all"
            , type_ "checkbox"
            , name "toggle"
            , checked allCompleted
            , onClick (MsgForTodoList <| CheckAll (not allCompleted))
            ]
            []
        , label [ for "toggle-all" ]
            [ text "Mark all as complete" ]
        , ul [ id "todo-list" ]
            (List.map todoItem (List.filter isVisible todos))
        ]
