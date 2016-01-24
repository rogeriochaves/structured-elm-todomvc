module Update.Task where

import Action.Main as Main exposing (..)
import Action.Task as Task exposing (..)
import Action.TaskList exposing (..)
import Model.Task exposing (Model, newTask)

update : Main.Action -> Model -> Model
update actionFor task =
  case actionFor of
    ActionForTaskEntry action -> updateTask action task
    ActionForTask _ action -> updateTask action task
    ActionForTaskList (Add id _) -> newTask (id + 1) ""
    _ -> task

updateTask : Task.Action -> Model -> Model
updateTask action model =
    case action of
      Check isCompleted ->
        { model | completed = isCompleted }

      Editing isEditing ->
        { model | editing = isEditing }

      Update description ->
        { model | description = description }
