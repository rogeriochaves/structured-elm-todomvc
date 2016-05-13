module TodoApp.Task.Update exposing (..)

import TodoApp.Msg as Main exposing (..)
import TodoApp.Task.Msg as Task exposing (..)
import TodoApp.TaskList.Msg as TaskList exposing (..)
import TodoApp.Task.Model exposing (Model, newTask)


update : Main.Msg -> Model -> Model
update actionFor task =
  case actionFor of
    MsgForTask _ action ->
      updateTask action task

    MsgForTaskEntry action ->
      updateTask action task

    MsgForTaskList (Add id _) ->
      newTask (id + 1) ""

    _ ->
      task


updateTask : Task.Msg -> Model -> Model
updateTask action model =
  case action of
    Check isCompleted ->
      { model | completed = isCompleted }

    Editing isEditing ->
      { model | editing = isEditing }

    Update description ->
      { model | description = description }
