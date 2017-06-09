module View.TodoApp exposing (..)

import Control.View.Controls as ControlsView
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Lazy exposing (lazy, lazy2)
import Model exposing (Model)
import Msg exposing (..)
import Todo.View.TodoEntry as TodoEntryView
import TodoList.View.TodoList as TodoListView
import View.InfoFooter exposing (infoFooter)


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
