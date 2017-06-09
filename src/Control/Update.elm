module Control.Update exposing (..)

import Control.Model exposing (Model)


type Msg
    = ChangeVisibility String
    | DeleteCompleted


type OutMsg
    = OutNoOp
    | TodoListDeleteCompleted


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeVisibility visibility ->
            { model | visibility = visibility }

        DeleteCompleted ->
            model


updateOutMsg : Msg -> Model -> OutMsg
updateOutMsg msg model =
    case msg of
        DeleteCompleted ->
            TodoListDeleteCompleted

        _ ->
            OutNoOp
