module Update.TodoList exposing (..)

import Model.Todo exposing (newTodo)
import Model.TodoList exposing (Model)
import Msg.Main as Main exposing (..)
import Msg.Todo as Todo exposing (..)
import Msg.TodoList as TodoList exposing (..)
import String
import Update.Todo as UpdateTodo


update : Main.Msg -> Model -> Model
update msgFor todoList =
    case msgFor of
        MsgForTodoList msg ->
            updateTodoList msg todoList

        _ ->
            todoList


updateTodoList : TodoList.Msg -> Model -> Model
updateTodoList msg todoList =
    case msg of
        Add id description ->
            if String.isEmpty description then
                todoList
            else
                todoList ++ [ newTodo id description ]

        Delete id ->
            List.filter (\t -> t.id /= id) todoList

        DeleteCompleted ->
            List.filter (not << .completed) todoList

        CheckAll isCompleted ->
            let
                updateTodo t =
                    UpdateTodo.updateTodo (Check isCompleted) t
            in
            List.map updateTodo todoList

        MsgForTodo id msg ->
            updateTodo id msg todoList


updateTodo : Int -> Todo.Msg -> Model -> Model
updateTodo id msg todoList =
    let
        updateTodo todo =
            if todo.id == id then
                UpdateTodo.updateTodo msg todo
            else
                todo
    in
    List.map updateTodo todoList


type alias FocusPort =
    String -> Cmd Main.Msg


updateCmd : FocusPort -> Main.Msg -> Cmd Main.Msg
updateCmd focus msg =
    case msg of
        MsgForTodoList (MsgForTodo id (Editing _)) ->
            focus ("#todo-" ++ toString id)

        _ ->
            Cmd.none
