module View exposing (..)

import Control.View as ControlsView
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Lazy exposing (lazy, lazy2)
import Layout.InfoFooter exposing (infoFooter)
import Model exposing (..)
import Todo.View.TodoEntry as TodoEntryView
import TodoList.View.TodoList as TodoListView
import Update exposing (..)


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
            [ Html.map MsgForTodoEntry <| lazy TodoEntryView.todoEntry todoEntry
            , Html.map MsgForTodoList <| lazy2 TodoListView.todoList control.visibility todoList
            , Html.map controlTranslator <| lazy2 ControlsView.controls control.visibility todoList
            ]
        , infoFooter
        ]
