module Update.Main exposing (..)

import Model.Main exposing (Model, initialModel)
import Msg.Main exposing (..)
import Update.Control as Control
import Update.Task as Task
import Update.TaskList as TaskList


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
