module Update.Task exposing (..)

import Msg.Main as Main exposing (..)
import Msg.Task as Task exposing (..)
import Msg.TaskList exposing (..)
import Model.Task exposing (Model, newTask)

update : Main.Msg -> Model -> Model
update msgFor task =
  case msgFor of
    MsgForTaskEntry msg -> updateTask msg task
    MsgForTask _ msg -> updateTask msg task
    MsgForTaskList (Add id _) -> newTask (id + 1) ""
    _ -> task

updateTask : Task.Msg -> Model -> Model
updateTask msg model =
    case msg of
      Check isCompleted ->
        { model | completed = isCompleted }

      Editing isEditing ->
        { model | editing = isEditing }

      Update description ->
        { model | description = description }
