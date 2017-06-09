module TodoList.View.TodoList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Todo.Model as Todo
import TodoList.Update exposing (..)
import TodoList.View.TodoItem exposing (todoItem)


todoList : String -> List Todo.Model -> Html InternalMsg
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
            , onClick (CheckAll (not allCompleted))
            ]
            []
        , label [ for "toggle-all" ]
            [ text "Mark all as complete" ]
        , ul [ id "todo-list" ]
            (List.map todoItem (List.filter isVisible todos))
        ]
