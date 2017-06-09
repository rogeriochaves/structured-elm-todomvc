module TodoApp.Update exposing (..)

import TodoApp.Control as Control
import TodoApp.Model exposing (Model)
import TodoApp.Msg exposing (..)
import TodoApp.Task.Update as Task
import TodoApp.TaskList.Update as TaskList


type alias FocusPort =
    String -> Cmd Msg


updateWithCmd : FocusPort -> Msg -> Model -> ( Model, Cmd Msg )
updateWithCmd focus msg model =
    ( update msg model, updateCmd focus msg )


update : Msg -> Model -> Model
update msg model =
    case msg of
        MsgForControl msg_ ->
            { model | control = Control.update msg_ model.control }

        _ ->
            { model
                | taskEntry = Task.update msg model.taskEntry
                , taskList = TaskList.update msg model.taskList
            }


updateCmd : FocusPort -> Msg -> Cmd Msg
updateCmd focus msg =
    Cmd.batch
        [ Task.updateTaskCmd focus msg
        ]
