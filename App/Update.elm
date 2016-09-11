module Update exposing (..)

import Msg exposing (..)
import Model exposing (Model)
import Task.Update as Task
import TaskList.Update as TaskList
import Control.Update as Control


type alias FocusPort =
    String -> Cmd Msg


updateWithCmd : FocusPort -> Msg -> Model -> ( Model, Cmd Msg )
updateWithCmd focus msg model =
    ( update msg model, updateCmd focus msg )


update : Msg -> Model -> Model
update msg model =
    { model
        | taskEntry = Task.update msg model.taskEntry
        , taskList = TaskList.update msg model.taskList
        , control = Control.update msg model.control
    }


updateCmd : FocusPort -> Msg -> Cmd Msg
updateCmd focus msg =
    Cmd.batch
        [ Task.updateTaskCmd focus msg
        ]
