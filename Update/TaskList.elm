module Update.TaskList exposing (..)

import Msg.Main as Main exposing (..)
import Msg.Task as Task exposing (..)
import Msg.TaskList as TaskList exposing (..)
import Model.Task exposing (newTask)
import Model.TaskList exposing (Model)
import Update.Task as UpdateTask
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
                updateTask t =
                    UpdateTask.updateTask (Check isCompleted) t
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
