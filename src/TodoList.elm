module TodoList exposing (..)

import Model.Todo exposing (newTodo)
import Model.TodoList exposing (..)
import Todo exposing (..)


type Msg
    = NoOp
    | Add Int String
    | Delete Int
    | DeleteCompleted
    | CheckAll Bool
    | MsgForTodo Int Todo.Msg


type OutMsg
    = OutNoOp
    | NewTodoEntry Int


update : Msg -> Model -> Model
update msgFor todoList =
    case msgFor of
        NoOp ->
            todoList

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
                    Todo.update (Check isCompleted) t
            in
            List.map updateTodo todoList

        MsgForTodo id msg ->
            updateTodo id msg todoList


updateTodo : Int -> Todo.Msg -> Model -> Model
updateTodo id msg todoList =
    let
        updateTodo todo =
            if todo.id == id then
                Todo.update msg todo
            else
                todo
    in
    List.map updateTodo todoList


type alias FocusPort a =
    String -> Cmd a


updateCmd : FocusPort a -> Msg -> Cmd a
updateCmd focus msg =
    case msg of
        MsgForTodo id (Editing _) ->
            focus ("#todo-" ++ toString id)

        _ ->
            Cmd.none


updateOutMsg : Msg -> Model -> OutMsg
updateOutMsg msgFor todoList =
    case msgFor of
        Add id description ->
            if String.isEmpty description then
                OutNoOp
            else
                NewTodoEntry (id + 1)

        _ ->
            OutNoOp
