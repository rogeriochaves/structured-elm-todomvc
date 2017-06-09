module Update.Main exposing (..)

import Model.Main exposing (Model, initialModel)
import Msg.Main exposing (..)
import Update.Control as Control
import Update.Todo as Todo
import Update.TodoList as TodoList


type alias FocusPort =
    String -> Cmd Msg


updateWithCmd : FocusPort -> Msg -> Model -> ( Model, Cmd Msg )
updateWithCmd focus msg model =
    ( update msg model, updateCmd focus msg )


update : Msg -> Model -> Model
update msg model =
    let
        model_ =
            { model | todoEntry = Todo.update msg model.todoEntry }
    in
    case msg of
        NoOp ->
            model_

        MsgForControl msg_ ->
            { model_ | control = Control.update msg_ model_.control }

        MsgForTodoList msg_ ->
            { model_ | todoList = TodoList.update msg_ model_.todoList }

        MsgForTodoEntry _ ->
            model_


updateCmd : FocusPort -> Msg -> Cmd Msg
updateCmd focus msg =
    Cmd.batch
        [ TodoList.updateCmd focus msg
        ]
