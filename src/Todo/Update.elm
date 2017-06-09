module Todo.Update exposing (..)

import Task
import Todo.Model exposing (..)


type InternalMsg
    = NoOp
    | Check Bool
    | Editing Bool
    | Update String
    | Add Int String


type OutMsg
    = TodoListAdd Int String


type Msg
    = ForSelf InternalMsg
    | ForParent OutMsg


type alias TranslationDictionary msg =
    { onInternalMessage : InternalMsg -> msg
    , onTodoListAdd : Int -> String -> msg
    }


type alias Translator msg =
    Msg -> msg


translator : TranslationDictionary msg -> Translator msg
translator { onInternalMessage, onTodoListAdd } msg =
    case msg of
        ForSelf internal ->
            onInternalMessage internal

        ForParent (TodoListAdd id description) ->
            onTodoListAdd id description


update : InternalMsg -> Model -> Model
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
            newTodo (id + 1) ""


updateCmd : InternalMsg -> Cmd Msg
updateCmd msg =
    case msg of
        Add id description ->
            Task.perform ForParent (Task.succeed <| TodoListAdd (id + 1) description)

        _ ->
            Cmd.none
