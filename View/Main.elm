module View.Main where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Lazy exposing (lazy, lazy2, lazy3)
import Action.Main exposing (..)
import Signal exposing (Address)
import Model.Main exposing (Model)
import View.TaskList.Main as TaskListView
import View.TaskEntry as TaskEntryView
import View.Controls as ControlsView
import View.InfoFooter exposing (infoFooter)

view : Address Action -> Model -> Html
view address model =
    let
      taskList = model.taskList
      taskEntry = model.taskEntry
      control = model.control
    in
      div
        [ class "todomvc-wrapper"
        , style [ ("visibility", "hidden") ]
        ]
        [ section
            [ id "todoapp" ]
            [ lazy2 TaskEntryView.taskEntry address taskEntry
            , lazy3 TaskListView.taskList address control.visibility taskList
            , lazy3 ControlsView.controls address control.visibility taskList
            ]
        , infoFooter
        ]
