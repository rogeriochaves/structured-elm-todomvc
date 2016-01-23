module View.Main where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Lazy exposing (lazy, lazy2, lazy3)
import Action.Main exposing (..)
import Signal exposing (Address)
import Model.Main exposing (Model)
import View.TaskList.Main as TaskListView
import View.TaskEntry exposing (taskEntry)
import View.Controls as Controls
import View.InfoFooter exposing (infoFooter)

view : Address Action -> Model -> Html
view address model =
    let
      taskList = model.taskList
    in
      div
        [ class "todomvc-wrapper"
        , style [ ("visibility", "hidden") ]
        ]
        [ section
            [ id "todoapp" ]
            [ lazy2 taskEntry address taskList.field
            , lazy3 TaskListView.taskList address taskList.visibility taskList.tasks
            , lazy3 Controls.controls address taskList.visibility taskList.tasks
            ]
        , infoFooter
        ]
