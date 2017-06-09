module Update exposing (..)

import Control.Update as Control
import Model exposing (..)
import Todo.Update as Todo
import TodoList.Update as TodoList


type Msg
    = MsgForTodoEntry Todo.InternalMsg
    | MsgForTodoList TodoList.InternalMsg
    | MsgForControl Control.InternalMsg


type alias FocusPort =
    String -> Cmd TodoList.Msg


updateWithCmd : FocusPort -> Msg -> Model -> ( Model, Cmd Msg )
updateWithCmd focus msg model =
    ( update msg model, updateCmd focus msg )


update : Msg -> Model -> Model
update msg model =
    case msg of
        MsgForControl msg_ ->
            { model | control = Control.update msg_ model.control }

        MsgForTodoEntry msg_ ->
            { model | todoEntry = Todo.update msg_ model.todoEntry }

        MsgForTodoList msg_ ->
            { model | todoList = TodoList.update msg_ model.todoList }


updateCmd : FocusPort -> Msg -> Cmd Msg
updateCmd focus msg =
    case msg of
        MsgForControl msg_ ->
            Control.updateCmd msg_
                |> Cmd.map controlTranslator

        MsgForTodoEntry msg_ ->
            Todo.updateCmd msg_
                |> Cmd.map todoTranslator

        MsgForTodoList msg_ ->
            TodoList.updateCmd focus msg_
                |> Cmd.map todoListTranslator


controlTranslator : Control.Translator Msg
controlTranslator =
    Control.translator
        { onInternalMessage = MsgForControl
        , onDeleteCompleted = MsgForTodoList TodoList.DeleteCompleted
        }


todoTranslator : Todo.Translator Msg
todoTranslator =
    Todo.translator
        { onInternalMessage = MsgForTodoEntry
        , onTodoListAdd = \id description -> MsgForTodoList <| TodoList.Add id description
        }


todoListTranslator : TodoList.Translator Msg
todoListTranslator =
    TodoList.translator
        { onInternalMessage = MsgForTodoList
        , onNewTodoEntry = \id -> MsgForTodoEntry <| Todo.Add id ""
        }
