module App exposing (..)

import Control as Control
import Control.View as ControlsView
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Lazy exposing (lazy, lazy2)
import Layout.InfoFooter exposing (infoFooter)
import Model exposing (..)
import Todo as Todo
import Todo.View.TodoEntry as TodoEntryView
import TodoList as TodoList
import TodoList.View.TodoList as TodoListView


init : Maybe Model -> ( Model, Cmd Msg )
init savedModel =
    Maybe.withDefault initialModel savedModel ! []


{-| We want to `setStorage` on every update. This function adds the setStorage
command for every step of the update function.
-}
withSetStorage : (Model -> Cmd Msg) -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
withSetStorage setStorage ( model, cmds ) =
    ( model, Cmd.batch [ setStorage model, cmds ] )


type Msg
    = MsgForTodoEntry Todo.Msg
    | MsgForTodoList TodoList.Msg
    | MsgForControl Control.Msg


type alias FocusPort =
    String -> Cmd Msg


updateWithCmd : FocusPort -> Msg -> Model -> ( Model, Cmd Msg )
updateWithCmd focus msg model =
    ( update msg model, updateCmd focus msg )


update : Msg -> Model -> Model
update msg model =
    (case msg of
        MsgForControl msg_ ->
            { model | control = Control.update msg_ model.control }

        MsgForTodoEntry msg_ ->
            { model | todoEntry = Todo.update msg_ model.todoEntry }

        MsgForTodoList msg_ ->
            { model | todoList = TodoList.update msg_ model.todoList }
    )
        |> updateOutMsg msg


updateOutMsg : Msg -> Model -> Model
updateOutMsg msg model =
    case msg of
        MsgForControl msg_ ->
            case Control.updateOutMsg msg_ model.control of
                Control.OutNoOp ->
                    model

                Control.TodoListDeleteCompleted ->
                    update (MsgForTodoList TodoList.DeleteCompleted) model

        MsgForTodoEntry msg_ ->
            case Todo.updateOutMsg msg_ model.todoEntry of
                Todo.OutNoOp ->
                    model

                Todo.TodoListAdd id description ->
                    update (MsgForTodoList <| TodoList.Add id description) model

        MsgForTodoList msg_ ->
            case TodoList.updateOutMsg msg_ model.todoList of
                TodoList.OutNoOp ->
                    model

                TodoList.NewTodoEntry id ->
                    update (MsgForTodoEntry <| Todo.Add id "") model


updateCmd : FocusPort -> Msg -> Cmd Msg
updateCmd focus msg =
    case msg of
        MsgForTodoList msg_ ->
            TodoList.updateCmd focus msg_

        _ ->
            Cmd.none


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
            , Html.map MsgForControl <| lazy2 ControlsView.controls control.visibility todoList
            ]
        , infoFooter
        ]
