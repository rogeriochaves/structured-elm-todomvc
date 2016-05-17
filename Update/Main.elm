module Update.Main exposing (..)

import Msg.Main exposing (..)
import Model.Main exposing (Model, initialModel)
import Update.Task as Task
import Update.TaskList as TaskList
import Update.Control as Control


type alias FocusPort =
    String -> Cmd Msg


update : FocusPort -> Msg -> Model -> ( Model, Cmd Msg )
update focus action model =
    ( { model
        | taskEntry = Task.update action model.taskEntry
        , taskList = TaskList.update action model.taskList
        , control = Control.update action model.control
      }
    , updateCmd focus action
    )


updateCmd : FocusPort -> Msg -> Cmd Msg
updateCmd focus action =
    Cmd.batch
        [ Task.updateTaskCmd focus action
        ]
