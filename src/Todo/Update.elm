module Todo.Update exposing (..)

import Todo.Model exposing (..)


type Msg
    = NoOp
    | Check Bool
    | Editing Bool
    | Update String
    | Add Int String


type OutMsg
    = OutNoOp
    | TodoListAdd Int String


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        Check isCompleted ->
            { model | completed = isCompleted }

        Editing isEditing ->
            { model | editing = isEditing }

        Update description ->
            { model | description = description }

        Add id description ->
            newTodo id ""


updateOutMsg : Msg -> Model -> OutMsg
updateOutMsg msg model =
    case msg of
        Add id description ->
            TodoListAdd id description

        _ ->
            OutNoOp
