module TodoApp.TaskList.Update where

import TodoApp.Action as Main exposing (..)
import TodoApp.Task.Action as Task exposing (..)
import TodoApp.TaskList.Action as TaskList exposing (..)
import TodoApp.Task.Model exposing (newTask)
import TodoApp.TaskList.Model exposing (Model)
import TodoApp.Task.Update as UpdateTask
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
      if String.isEmpty description
        then taskList
        else taskList ++ [newTask id description]

    Delete id ->
      List.filter (\t -> t.id /= id) taskList

    DeleteComplete ->
      List.filter (not << .completed) taskList

    CheckAll isCompleted ->
      let updateTask t = UpdateTask.updateTask (Check isCompleted) t
      in
        List.map updateTask taskList

updateTask : Int -> Task.Action -> Model -> Model
updateTask id action taskList =
  let
    updateTask task = if task.id == id then UpdateTask.updateTask action task else task
  in
    List.map updateTask taskList
