module TodoApp.View.TodoApp exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Lazy exposing (lazy, lazy2)
import TodoApp.Model exposing (Model)
import TodoApp.Msg exposing (..)
import TodoApp.View.Controls as ControlsView
import TodoApp.View.InfoFooter exposing (infoFooter)
import TodoApp.View.Task.TaskEntry as TaskEntryView
import TodoApp.View.TaskList as TaskListView


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
