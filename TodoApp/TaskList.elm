module TodoApp.TaskList exposing (..)

import TodoApp.Task as Task exposing (..)


type alias Model =
    List Task.Model


model : Model
model =
    []


type Msg
    = NoOp
    | Add Int String
    | Delete Int
    | DeleteComplete
    | CheckAll Bool
    | MsgForTask Int Task.Msg


type OutMsg
    = OutNoOp
    | NewTaskEntry Int


update : Msg -> Model -> ( Model, OutMsg )
update msgFor taskList =
    case msgFor of
        NoOp ->
            ( taskList, OutNoOp )

        Add id description ->
            if String.isEmpty description then
                ( taskList, OutNoOp )
            else
                ( taskList ++ [ newTask id description ], NewTaskEntry (id + 1) )

        Delete id ->
            ( List.filter (\t -> t.id /= id) taskList, OutNoOp )

        DeleteComplete ->
            ( List.filter (not << .completed) taskList, OutNoOp )

        CheckAll isCompleted ->
            let
                updateTask t =
                    Task.update (Check isCompleted) t
                        |> Tuple.first
            in
            ( List.map updateTask taskList, OutNoOp )

        MsgForTask id msg ->
            ( updateTask id msg taskList, OutNoOp )


updateTask : Int -> Task.Msg -> Model -> Model
updateTask id msg taskList =
    let
        updateTask task =
            if task.id == id then
                Task.update msg task
                    |> Tuple.first
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
