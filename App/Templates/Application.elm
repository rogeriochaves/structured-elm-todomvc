module Templates.Application exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Lazy exposing (lazy, lazy2)
import Msg exposing (..)
import Model exposing (Model)
import TaskList.View.TaskList as TaskListView
import Task.View.TaskEntry as TaskEntryView
import Control.View.Controls as ControlsView
import Templates.InfoFooter exposing (infoFooter)


view : Model -> Html Msg
view model =
    let
        taskList =
            model.taskList

        taskEntry =
            model.taskEntry

        control =
            model.control
    in
        div
            [ class "todomvc-wrapper"
            , style [ ( "visibility", "hidden" ) ]
            ]
            [ section [ id "todoapp" ]
                [ lazy TaskEntryView.taskEntry taskEntry
                , lazy2 TaskListView.taskList control.visibility taskList
                , lazy2 ControlsView.controls control.visibility taskList
                ]
            , infoFooter
            ]
