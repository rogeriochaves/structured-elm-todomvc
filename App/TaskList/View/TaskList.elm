module App.TaskList.View.TaskList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import App.Msg as Main exposing (..)
import App.TaskList.Msg exposing (..)
import App.Task.Model as Task
import App.Task.View.TodoItem exposing (todoItem)


taskList : String -> List Task.Model -> Html Main.Msg
taskList visibility tasks =
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
            List.all .completed tasks

        cssVisibility =
            if List.isEmpty tasks then
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
                , type' "checkbox"
                , name "toggle"
                , checked allCompleted
                , onClick (MsgForTaskList <| CheckAll (not allCompleted))
                ]
                []
            , label [ for "toggle-all" ]
                [ text "Mark all as complete" ]
            , ul [ id "todo-list" ]
                (List.map todoItem (List.filter isVisible tasks))
            ]
