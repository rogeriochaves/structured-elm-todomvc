module Update exposing (..)

import Control.Update as Control
import Model exposing (..)
import Todo.Update as Todo
import TodoList.Update as TodoList


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
            model


updateCmd : FocusPort -> Msg -> Cmd Msg
updateCmd focus msg =
    case msg of
        MsgForTodoList msg_ ->
            TodoList.updateCmd focus msg_

        _ ->
            Cmd.none
