module Update.Todo exposing (..)

import Model.Todo exposing (Model, newTodo)
import Msg.Main as Main exposing (..)
import Msg.Todo as Todo exposing (..)
import Msg.TodoList exposing (..)


update : Main.Msg -> Model -> Model
update msgFor todo =
    case msgFor of
        MsgForTodoEntry msg ->
            updateTodo msg todo

        MsgForTodo _ msg ->
            updateTodo msg todo

        MsgForTodoList (Add id _) ->
            newTodo (id + 1) ""

        _ ->
            todo


updateTodo : Todo.Msg -> Model -> Model
updateTodo msg model =
    case msg of
        Check isCompleted ->
            { model | completed = isCompleted }

        Editing isEditing ->
            { model | editing = isEditing }

        Update description ->
            { model | description = description }


type alias FocusPort =
    String -> Cmd Main.Msg


updateTodoCmd : FocusPort -> Main.Msg -> Cmd Main.Msg
updateTodoCmd focus msg =
    case msg of
        MsgForTodo id (Editing _) ->
            focus ("#todo-" ++ toString id)

        _ ->
            Cmd.none
