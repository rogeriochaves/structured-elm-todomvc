module Todo exposing (..)

import Model.Todo exposing (..)


type Msg
    = NoOp
    | Check Bool
    | Editing Bool
    | Update String
    | Add Int String


type OutMsg
    = OutNoOp
    | TodoListAdd Int String


update : Msg -> Model -> ( Model, OutMsg )
update msg model =
    case msg of
        NoOp ->
            ( model, OutNoOp )

        Check isCompleted ->
            ( { model | completed = isCompleted }, OutNoOp )

        Editing isEditing ->
            ( { model | editing = isEditing }, OutNoOp )

        Update description ->
            ( { model | description = description }, OutNoOp )

        Add id description ->
            ( newTodo id "", TodoListAdd id description )
