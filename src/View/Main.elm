module View.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Lazy exposing (lazy, lazy2)
import Model.Main exposing (Model)
import Msg.Main exposing (..)
import View.Controls as ControlsView
import View.InfoFooter exposing (infoFooter)
import View.TodoEntry as TodoEntryView
import View.TodoList.Main as TodoListView


view : Model -> Html Msg
view model =
    let
        todoList =
            model.todoList

        todoEntry =
            model.todoEntry

        control =
            model.control
    in
    div
        [ class "todomvc-wrapper"
        , style [ ( "visibility", "hidden" ) ]
        ]
        [ section [ id "todoapp" ]
            [ lazy TodoEntryView.todoEntry todoEntry
            , lazy2 TodoListView.todoList control.visibility todoList
            , lazy2 ControlsView.controls control.visibility todoList
            ]
        , infoFooter
        ]
