module View.Controls where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Action.Main as Main exposing (..)
import Action.TaskList exposing (..)
import Action.Control exposing (..)
import Signal exposing (Signal, Address)
import Model.Task as Task

controls : Address Main.Action -> String -> List Task.Model -> Html
controls address visibility tasks =
    let tasksCompleted = List.length (List.filter .completed tasks)
        tasksLeft = List.length tasks - tasksCompleted
        item_ = if tasksLeft == 1 then " item" else " items"
    in
    footer
      [ id "footer"
      , hidden (List.isEmpty tasks)
      ]
      [ span
          [ id "todo-count" ]
          [ strong [] [ text (toString tasksLeft) ]
          , text (item_ ++ " left")
          ]
      , ul
          [ id "filters" ]
          [ visibilitySwap address "#/" "All" visibility
          , text " "
          , visibilitySwap address "#/active" "Active" visibility
          , text " "
          , visibilitySwap address "#/completed" "Completed" visibility
          ]
      , button
          [ class "clear-completed"
          , id "clear-completed"
          , hidden (tasksCompleted == 0)
          , onClick address (ActionForTaskList DeleteComplete)
          ]
          [ text ("Clear completed (" ++ toString tasksCompleted ++ ")") ]
      ]


visibilitySwap : Address Main.Action -> String -> String -> String -> Html
visibilitySwap address uri visibility actualVisibility =
    li
      [ onClick address (ActionForControl <| ChangeVisibility visibility) ]
      [ a [ href uri, classList [("selected", visibility == actualVisibility)] ] [ text visibility ] ]
