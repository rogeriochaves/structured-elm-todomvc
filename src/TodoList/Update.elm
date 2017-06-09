module TodoList.Update exposing (..)

import String
import Msg as Main exposing (..)
import Todo.Model exposing (newTodo)
import Todo.Msg as Todo exposing (..)
import Todo.Update as UpdateTodo
import TodoList.Model exposing (Model)
import TodoList.Msg as TodoList exposing (..)


update : Main.Msg -> Model -> Model
update msgFor todoList =
    case msgFor of
        MsgForTodoList msg ->
            updateTodoList msg todoList

        MsgForTodo id msg ->
            updateTodo id msg todoList

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

        DeleteComplete ->
            List.filter (not << .completed) todoList

        CheckAll isCompleted ->
            let
                updateTodo t =
                    UpdateTodo.updateTodo (Check isCompleted) t
            in
            List.map updateTodo todoList


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
