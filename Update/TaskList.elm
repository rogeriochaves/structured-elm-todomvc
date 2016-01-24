module Update.TaskList where

import Action.Main as Main exposing (..)
import Action.Task as Task exposing (..)
import Action.TaskList as TaskList exposing (..)
import Model.Task exposing (newTask)
import Model.TaskList exposing (Model)
import Update.Task as UpdateTask
import String

update : Main.Action -> Model -> Model
update actionFor taskList =
  case actionFor of
    ActionForTaskList action -> updateTaskList action taskList
    ActionForTask id action -> updateTask id action taskList
    _ -> taskList

updateTaskList : TaskList.Action -> Model -> Model
updateTaskList action taskList =
  case action of
    Add id description ->
      { taskList |
          tasks =
              if String.isEmpty description
                then taskList.tasks
                else taskList.tasks ++ [newTask id description]
      }

    Delete id ->
      { taskList | tasks = List.filter (\t -> t.id /= id) taskList.tasks }

    DeleteComplete ->
      { taskList | tasks = List.filter (not << .completed) taskList.tasks }

    CheckAll isCompleted ->
      let updateTask t = UpdateTask.updateTask (Check isCompleted) t
      in
        { taskList | tasks = List.map updateTask taskList.tasks }

updateTask : Int -> Task.Action -> Model -> Model
updateTask id action taskList =
  let
    updateTask task = if task.id == id then UpdateTask.updateTask action task else task
  in
    { taskList | tasks = List.map updateTask taskList.tasks }
