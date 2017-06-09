module Control exposing (..)

import Model.Control exposing (Model)


type Msg
    = ChangeVisibility String
    | DeleteCompleted


type OutMsg
    = OutNoOp
    | TodoListDeleteCompleted


update : Msg -> Model -> ( Model, OutMsg )
update msg model =
    case msg of
        ChangeVisibility visibility ->
            ( { model | visibility = visibility }, OutNoOp )

        DeleteCompleted ->
            ( model, TodoListDeleteCompleted )
