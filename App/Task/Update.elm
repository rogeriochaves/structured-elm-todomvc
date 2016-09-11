module Task.Update exposing (..)

import Msg as Main exposing (..)
import Task.Msg as Task exposing (..)
import TaskList.Msg exposing (..)
import Task.Model exposing (Model, newTask)


update : Main.Msg -> Model -> Model
update msgFor task =
    case msgFor of
        MsgForTaskEntry msg ->
            updateTask msg task

        MsgForTask _ msg ->
            updateTask msg task

        MsgForTaskList (Add id _) ->
            newTask (id + 1) ""

        _ ->
            task


updateTask : Task.Msg -> Model -> Model
updateTask msg model =
    case msg of
        Check isCompleted ->
            { model | completed = isCompleted }

        Editing isEditing ->
            { model | editing = isEditing }

        Update description ->
            { model | description = description }


type alias FocusPort =
    String -> Cmd Main.Msg


updateTaskCmd : FocusPort -> Main.Msg -> Cmd Main.Msg
updateTaskCmd focus msg =
    case msg of
        MsgForTask id (Editing _) ->
            focus ("#todo-" ++ toString id)

        _ ->
            Cmd.none
