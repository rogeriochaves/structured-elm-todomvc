module Model exposing (..)

import Control.Model as Control
import Msg exposing (Msg)
import Task.Model as Task
import TaskList.Model as TaskList


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
