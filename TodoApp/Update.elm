module TodoApp.Update exposing (..)

import TodoApp.Control as Control
import TodoApp.Model exposing (Model)
import TodoApp.Msg exposing (..)
import TodoApp.Task as Task
import TodoApp.TaskList as TaskList


type alias FocusPort =
    String -> Cmd Msg


updateWithCmd : FocusPort -> Msg -> Model -> ( Model, Cmd Msg )
updateWithCmd focus msg model =
    ( update msg model, updateCmd focus msg )


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        MsgForControl msg_ ->
            { model | control = Control.update msg_ model.control }

        MsgForTaskEntry msg_ ->
            { model | taskEntry = Task.update msg_ model.taskEntry }

        MsgForTaskList msg_ ->
            let
                ( taskList, outMsg ) =
                    TaskList.update msg_ model.taskList

                model_ =
                    { model | taskList = taskList }
            in
            case outMsg of
                TaskList.NoOp ->
                    model_

                TaskList.NewTaskEntry id ->
                    update (MsgForTaskEntry <| Task.New id) model_


updateCmd : FocusPort -> Msg -> Cmd Msg
updateCmd focus msg =
    case msg of
        MsgForTaskList msg_ ->
            TaskList.updateTaskCmd focus msg_

        _ ->
            Cmd.none
