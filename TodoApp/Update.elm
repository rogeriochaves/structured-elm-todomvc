module TodoApp.Update exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Lazy exposing (lazy, lazy2)
import TodoApp.Control as Control
import TodoApp.Task as Task
import TodoApp.TaskList as TaskList
import TodoApp.View.Controls as ControlsView
import TodoApp.View.InfoFooter exposing (infoFooter)
import TodoApp.View.Task.TaskEntry as TaskEntryView
import TodoApp.View.TaskList as TaskListView


type alias Model =
    { taskEntry : Task.Model
    , taskList : TaskList.Model
    , control : Control.Model
    }


initialModel : Model
initialModel =
    { taskEntry = Task.model
    , taskList = TaskList.model
    , control = Control.model
    }


init : Maybe Model -> ( Model, Cmd Msg )
init savedModel =
    Maybe.withDefault initialModel savedModel ! []


{-| We want to `setStorage` on every update. This function adds the setStorage
command for every step of the update function.
-}
withSetStorage : (Model -> Cmd Msg) -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
withSetStorage setStorage ( model, cmds ) =
    ( model, Cmd.batch [ setStorage model, cmds ] )


type Msg
    = MsgForTaskEntry Task.Msg
    | MsgForTaskList TaskList.Msg
    | MsgForControl Control.Msg


type alias FocusPort =
    String -> Cmd Msg


updateWithCmd : FocusPort -> Msg -> Model -> ( Model, Cmd Msg )
updateWithCmd focus msg model =
    ( update msg model, updateCmd focus msg )


update : Msg -> Model -> Model
update msg model =
    case msg of
        MsgForControl msg_ ->
            { model | control = Control.update msg_ model.control }

        MsgForTaskEntry msg_ ->
            let
                ( taskEntry, outMsg ) =
                    Task.update msg_ model.taskEntry

                model_ =
                    { model | taskEntry = taskEntry }
            in
            case outMsg of
                Task.OutNoOp ->
                    model_

                Task.TaskListAdd id description ->
                    update (MsgForTaskList <| TaskList.Add id description) model_

        MsgForTaskList msg_ ->
            let
                ( taskList, outMsg ) =
                    TaskList.update msg_ model.taskList

                model_ =
                    { model | taskList = taskList }
            in
            case outMsg of
                TaskList.OutNoOp ->
                    model_

                TaskList.NewTaskEntry id ->
                    update (MsgForTaskEntry <| Task.Add id "") model_


updateCmd : FocusPort -> Msg -> Cmd Msg
updateCmd focus msg =
    case msg of
        MsgForTaskList msg_ ->
            TaskList.updateTaskCmd focus msg_

        _ ->
            Cmd.none


view : Model -> Html Msg
view model =
    let
        taskList =
            model.taskList

        taskEntry =
            model.taskEntry

        control =
            model.control
    in
    div
        [ class "todomvc-wrapper"
        , style [ ( "visibility", "hidden" ) ]
        ]
        [ section [ id "todoapp" ]
            [ Html.map MsgForTaskEntry <| lazy TaskEntryView.taskEntry taskEntry
            , Html.map MsgForTaskList <| lazy2 TaskListView.taskList control.visibility taskList
            , Html.map MsgForControl <| lazy2 ControlsView.controls control.visibility taskList
            ]
        , infoFooter
        ]
