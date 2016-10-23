module TodoApp.Update exposing (..)

import TodoApp.Msg exposing (..)
import TodoApp.Model exposing (Model)
import TodoApp.Task.Update as Task
import TodoApp.TaskList.Update as TaskList
import TodoApp.Control.Update as Control


type alias FocusPort =
    String -> Cmd Msg


updateWithCmd : Msg -> Model -> ( Model, Cmd Msg )
updateWithCmd msg model =
    ( update msg model, updateCmd msg )


update : Msg -> Model -> Model
update msg model =
    { model
        | taskEntry = Task.update msg model.taskEntry
        , taskList = TaskList.update msg model.taskList
        , control = Control.update msg model.control
    }


updateCmd : Msg -> Cmd Msg
updateCmd msg =
    Cmd.batch
        [ Task.updateTaskCmd msg
        ]
