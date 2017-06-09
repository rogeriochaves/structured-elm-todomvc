module Control.Update exposing (..)

import Control.Model exposing (Model)
import Task


type InternalMsg
    = ChangeVisibility String
    | DeleteCompleted


type OutMsg
    = TodoListDeleteCompleted


type Msg
    = ForSelf InternalMsg
    | ForParent OutMsg


type alias TranslationDictionary msg =
    { onInternalMessage : InternalMsg -> msg
    , onDeleteCompleted : msg
    }


type alias Translator msg =
    Msg -> msg


translator : TranslationDictionary msg -> Translator msg
translator { onInternalMessage, onDeleteCompleted } msg =
    case msg of
        ForSelf internal ->
            onInternalMessage internal

        ForParent TodoListDeleteCompleted ->
            onDeleteCompleted


update : InternalMsg -> Model -> Model
update msg model =
    case msg of
        ChangeVisibility visibility ->
            { model | visibility = visibility }

        DeleteCompleted ->
            model


updateCmd : InternalMsg -> Cmd Msg
updateCmd msg =
    case msg of
        DeleteCompleted ->
            Task.perform ForParent (Task.succeed TodoListDeleteCompleted)

        _ ->
            Cmd.none
