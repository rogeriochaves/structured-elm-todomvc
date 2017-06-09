module TodoList.Update exposing (..)

import Task
import Todo.Model exposing (newTodo)
import Todo.Update exposing (..)
import TodoList.Model exposing (..)


type InternalMsg
    = NoOp
    | Add Int String
    | Delete Int
    | DeleteCompleted
    | CheckAll Bool
    | MsgForTodo Int Todo.Update.InternalMsg


type OutMsg
    = NewTodoEntry Int


type Msg
    = ForSelf InternalMsg
    | ForParent OutMsg


type alias TranslationDictionary msg =
    { onInternalMessage : InternalMsg -> msg
    , onNewTodoEntry : Int -> msg
    }


type alias Translator msg =
    Msg -> msg


translator : TranslationDictionary msg -> Translator msg
translator { onInternalMessage, onNewTodoEntry } msg =
    case msg of
        ForSelf internal ->
            onInternalMessage internal

        ForParent (NewTodoEntry id) ->
            onNewTodoEntry id


update : InternalMsg -> Model -> Model
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
                    Todo.Update.update (Check isCompleted) t
            in
            List.map updateTodo todoList

        MsgForTodo id msg ->
            updateTodo id msg todoList


updateTodo : Int -> Todo.Update.InternalMsg -> Model -> Model
updateTodo id msg todoList =
    let
        updateTodo todo =
            if todo.id == id then
                Todo.Update.update msg todo
            else
                todo
    in
    List.map updateTodo todoList


type alias FocusPort =
    String -> Cmd Msg


updateCmd : FocusPort -> InternalMsg -> Cmd Msg
updateCmd focus msg =
    case msg of
        MsgForTodo id (Editing _) ->
            focus ("#todo-" ++ toString id)

        Add id description ->
            Task.perform ForParent (Task.succeed <| NewTodoEntry (id + 1))

        _ ->
            Cmd.none
