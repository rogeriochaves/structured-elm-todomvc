module TodoApp.TaskList exposing (..)

import TodoApp.Task as Task exposing (..)


type alias Model =
    List Task.Model


model : Model
model =
    []


type Msg
    = Add Int String
    | Delete Int
    | DeleteComplete
    | CheckAll Bool
    | MsgForTask Int Task.Msg


update : Msg -> Model -> Model
update msgFor taskList =
    case msgFor of
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
                    Task.update (Check isCompleted) t
            in
            List.map updateTask taskList

        MsgForTask id msg ->
            updateTask id msg taskList


updateTask : Int -> Task.Msg -> Model -> Model
updateTask id msg taskList =
    let
        updateTask task =
            if task.id == id then
                Task.update msg task
            else
                task
    in
    List.map updateTask taskList


type alias FocusPort a =
    String -> Cmd a


updateTaskCmd : FocusPort a -> Msg -> Cmd a
updateTaskCmd focus msg =
    case msg of
        MsgForTask id (Editing _) ->
            focus ("#todo-" ++ toString id)

        _ ->
            Cmd.none
