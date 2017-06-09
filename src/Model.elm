module Model exposing (..)

import Control.Model as Control
import Msg exposing (Msg)
import Todo.Model as Todo
import TodoList.Model as TodoList


type alias Model =
    { todoEntry : Todo.Model
    , todoList : TodoList.Model
    , control : Control.Model
    }


initialModel : Model
initialModel =
    { todoEntry = Todo.model
    , todoList = TodoList.model
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
