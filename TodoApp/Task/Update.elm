module TodoApp.Task.Update exposing (..)

import Dom
import TodoApp.Msg as Main exposing (..)
import TodoApp.Task.Msg as Task exposing (..)
import TodoApp.TaskList.Msg exposing (..)
import TodoApp.Task.Model exposing (Model, newTask)
import Task exposing (perform)


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


updateTaskCmd : Main.Msg -> Cmd Main.Msg
updateTaskCmd msg =
    case msg of
        MsgForTask id (Editing _) ->
            let
                focus =
                    Dom.focus ("todo-" ++ toString id)
            in
                perform (\_ -> NoOp) (\_ -> NoOp) focus

        _ ->
            Cmd.none
