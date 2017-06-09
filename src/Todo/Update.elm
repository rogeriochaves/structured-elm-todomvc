module Todo.Update exposing (..)

import Msg as Main exposing (..)
import Todo.Model exposing (Model, newTodo)
import Todo.Msg as Todo exposing (..)
import TodoList.Msg exposing (..)


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
