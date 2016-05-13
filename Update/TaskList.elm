module Update.TaskList exposing (..)

import Msg.Main as Main exposing (..)
import Msg.Task as Task exposing (..)
import Msg.TaskList as TaskList exposing (..)
import Model.Task exposing (newTask)
import Model.TaskList exposing (Model)
import Update.Task as UpdateTask
import String

update : Main.Msg -> Model -> Model
update msgFor taskList =
  case msgFor of
    MsgForTaskList msg -> updateTaskList msg taskList
    MsgForTask id msg -> updateTask id msg taskList
    _ -> taskList

updateTaskList : TaskList.Msg -> Model -> Model
updateTaskList msg taskList =
  case msg of
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

updateTask : Int -> Task.Msg -> Model -> Model
updateTask id msg taskList =
  let
    updateTask task = if task.id == id then UpdateTask.updateTask msg task else task
  in
    List.map updateTask taskList
