module Update exposing (..)

import Control.Update as Control
import Model exposing (Model)
import Msg exposing (..)
import Todo.Update as Todo
import TodoList.Update as TodoList


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
        [ TodoList.updateCmd focus msg
        ]
