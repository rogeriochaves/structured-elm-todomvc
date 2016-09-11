module App.Update exposing (..)

import App.Msg exposing (..)
import App.Model exposing (Model)
import App.Task.Update as Task
import App.TaskList.Update as TaskList
import App.Control.Update as Control


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
