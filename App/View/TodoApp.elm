module App.View.TodoApp exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Lazy exposing (lazy, lazy2)
import App.Msg exposing (..)
import App.Model exposing (Model)
import App.TaskList.View.TaskList as TaskListView
import App.Task.View.TaskEntry as TaskEntryView
import App.Control.View.Controls as ControlsView
import App.View.InfoFooter exposing (infoFooter)


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
