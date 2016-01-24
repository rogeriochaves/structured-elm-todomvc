module TodoApp.Task.Update where

import TodoApp.Action as Main exposing (..)
import TodoApp.Task.Action as Task exposing (..)
import TodoApp.TaskList.Action exposing (..)
import TodoApp.Task.Model exposing (Model, newTask)

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
