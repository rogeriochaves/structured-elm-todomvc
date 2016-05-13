module TodoApp.TaskList.Update exposing (..)

import TodoApp.Msg as Main exposing (..)
import TodoApp.Task.Msg as Task exposing (..)
import TodoApp.TaskList.Msg as TaskList exposing (..)
import TodoApp.Task.Model exposing (newTask)
import TodoApp.TaskList.Model exposing (Model)
import TodoApp.Task.Update as UpdateTask
import String


update : Main.Msg -> Model -> Model
update actionFor taskList =
  case actionFor of
    MsgForTaskList action ->
      updateTaskList action taskList

    MsgForTask id action ->
      updateTask id action taskList

    _ ->
      taskList


updateTaskList : TaskList.Msg -> Model -> Model
updateTaskList action taskList =
  case action of
    Add id description ->
      if String.isEmpty description then
        taskList
      else
        taskList ++ [ newTask id description ]

    Delete id ->
      List.filter (\t -> t.id /= id) taskList

    DeleteComplete ->
      List.filter (not << .completed) taskList

    CheckAll isCompleted ->
      let
        updateTask task =
          UpdateTask.updateTask (Check isCompleted) task
      in
        List.map updateTask taskList


updateTask : Int -> Task.Msg -> Model -> Model
updateTask id action taskList =
  let
    updateTask task =
      if task.id == id then
        UpdateTask.updateTask action task
      else
        task
  in
    List.map updateTask taskList
