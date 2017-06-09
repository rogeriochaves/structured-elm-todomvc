module TodoApp.Task.Update exposing (..)

import TodoApp.Task.Model exposing (Model, newTask)
import TodoApp.Task.Msg as Task exposing (..)


-- update : Main.Msg -> Model -> Model
-- update msgFor task =
--     case msgFor of
--         MsgForTaskEntry msg ->
--             updateTask msg task
--
--         MsgForTask _ msg ->
--             updateTask msg task
--
--         MsgForTaskList (Add id _) ->
--             newTask (id + 1) ""
--
--         _ ->
--             task


update : Task.Msg -> Model -> Model
update msg model =
    case msg of
        Check isCompleted ->
            { model | completed = isCompleted }

        Editing isEditing ->
            { model | editing = isEditing }

        Update description ->
            { model | description = description }
