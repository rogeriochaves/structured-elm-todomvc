module TodoList exposing (..)

import Todo as Todo exposing (..)


type alias Model =
    List Todo.Model


model : Model
model =
    []


type Msg
    = NoOp
    | Add Int String
    | Delete Int
    | DeleteCompleted
    | CheckAll Bool
    | MsgForTodo Int Todo.Msg


type OutMsg
    = OutNoOp
    | NewTodoEntry Int


update : Msg -> Model -> ( Model, OutMsg )
update msgFor todoList =
    case msgFor of
        NoOp ->
            ( todoList, OutNoOp )

        Add id description ->
            if String.isEmpty description then
                ( todoList, OutNoOp )
            else
                ( todoList ++ [ newTodo id description ], NewTodoEntry (id + 1) )

        Delete id ->
            ( List.filter (\t -> t.id /= id) todoList, OutNoOp )

        DeleteCompleted ->
            ( List.filter (not << .completed) todoList, OutNoOp )

        CheckAll isCompleted ->
            let
                updateTodo t =
                    Todo.update (Check isCompleted) t
                        |> Tuple.first
            in
            ( List.map updateTodo todoList, OutNoOp )

        MsgForTodo id msg ->
            ( updateTodo id msg todoList, OutNoOp )


updateTodo : Int -> Todo.Msg -> Model -> Model
updateTodo id msg todoList =
    let
        updateTodo todo =
            if todo.id == id then
                Todo.update msg todo
                    |> Tuple.first
            else
                todo
    in
    List.map updateTodo todoList


type alias FocusPort a =
    String -> Cmd a


updateTodoCmd : FocusPort a -> Msg -> Cmd a
updateTodoCmd focus msg =
    case msg of
        MsgForTodo id (Editing _) ->
            focus ("#todo-" ++ toString id)

        _ ->
            Cmd.none
