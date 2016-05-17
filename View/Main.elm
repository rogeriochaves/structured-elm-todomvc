module View.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Lazy exposing (lazy, lazy2)
import Msg.Main exposing (..)
import TodoApp.Model exposing (Model)
import View.TaskList.Main as TaskListView
import View.TaskEntry as TaskEntryView
import View.Controls as ControlsView
import View.InfoFooter exposing (infoFooter)


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
