module TodoApp.Update exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Lazy exposing (lazy, lazy2)
import TodoApp.Control as Control
import TodoApp.Msg exposing (..)
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
            [ lazy TaskEntryView.taskEntry taskEntry
            , lazy2 TaskListView.taskList control.visibility taskList
            , lazy2 ControlsView.controls control.visibility taskList
            ]
        , infoFooter
        ]
