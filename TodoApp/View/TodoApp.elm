module TodoApp.View.TodoApp exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Lazy exposing (lazy, lazy2)
import TodoApp.Control.View.Controls as ControlsView
import TodoApp.Model exposing (Model)
import TodoApp.Msg exposing (..)
import TodoApp.Task.View.TaskEntry as TaskEntryView
import TodoApp.TaskList.View.TaskList as TaskListView
import TodoApp.View.InfoFooter exposing (infoFooter)


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
