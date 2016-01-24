module TodoApp.TaskList.View.TaskList where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import TodoApp.Action as Main exposing (..)
import TodoApp.TaskList.Action exposing (..)
import Signal exposing (Address)
import TodoApp.Task.Model as Task
import TodoApp.Task.View.TodoItem exposing (todoItem)

taskList : Address Main.Action -> String -> List Task.Model -> Html
taskList address visibility tasks =
    let isVisible todo =
            case visibility of
              "Completed" -> todo.completed
              "Active" -> not todo.completed
              _ -> True

        allCompleted = List.all .completed tasks

        cssVisibility = if List.isEmpty tasks then "hidden" else "visible"
    in
    section
      [ id "main"
      , style [ ("visibility", cssVisibility) ]
      ]
      [ input
          [ id "toggle-all"
          , type' "checkbox"
          , name "toggle"
          , checked allCompleted
          , onClick address (ActionForTaskList <| CheckAll (not allCompleted))
          ]
          []
      , label
          [ for "toggle-all" ]
          [ text "Mark all as complete" ]
      , ul
          [ id "todo-list" ]
          (List.map (todoItem address) (List.filter isVisible tasks))
      ]
