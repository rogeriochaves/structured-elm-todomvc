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
    { model
        | todoEntry = Todo.update msg model.todoEntry
        , todoList = TodoList.update msg model.todoList
        , control = Control.update msg model.control
    }


updateCmd : FocusPort -> Msg -> Cmd Msg
updateCmd focus msg =
    Cmd.batch
        [ Todo.updateTodoCmd focus msg
        ]
