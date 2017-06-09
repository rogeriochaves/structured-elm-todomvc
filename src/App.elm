module App exposing (..)

import Control as Control
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Lazy exposing (lazy, lazy2)
import Model.App exposing (..)
import Todo as Todo
import TodoList as TodoList
import View.Controls as ControlsView
import View.InfoFooter exposing (infoFooter)
import View.Todo.TodoEntry as TodoEntryView
import View.TodoList as TodoListView


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
    case msg of
        MsgForControl msg_ ->
            let
                ( control, outMsg ) =
                    Control.update msg_ model.control

                model_ =
                    { model | control = control }
            in
            case outMsg of
                Control.OutNoOp ->
                    model_

                Control.TodoListDeleteCompleted ->
                    update (MsgForTodoList TodoList.DeleteCompleted) model_

        MsgForTodoEntry msg_ ->
            let
                ( todoEntry, outMsg ) =
                    Todo.update msg_ model.todoEntry

                model_ =
                    { model | todoEntry = todoEntry }
            in
            case outMsg of
                Todo.OutNoOp ->
                    model_

                Todo.TodoListAdd id description ->
                    update (MsgForTodoList <| TodoList.Add id description) model_

        MsgForTodoList msg_ ->
            let
                ( todoList, outMsg ) =
                    TodoList.update msg_ model.todoList

                model_ =
                    { model | todoList = todoList }
            in
            case outMsg of
                TodoList.OutNoOp ->
                    model_

                TodoList.NewTodoEntry id ->
                    update (MsgForTodoEntry <| Todo.Add id "") model_


updateCmd : FocusPort -> Msg -> Cmd Msg
updateCmd focus msg =
    case msg of
        MsgForTodoList msg_ ->
            TodoList.updateTodoCmd focus msg_

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
