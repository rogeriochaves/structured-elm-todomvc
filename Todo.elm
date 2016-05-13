port module Todo exposing (..)

import Html exposing (..)
import Html.App as App
import TodoApp.Msg exposing (..)
import TodoApp.Model exposing (Model, init)
import TodoApp.View.TodoApp exposing (view)
import TodoApp.Update exposing (update)


main : Program (Maybe Model)
main =
  App.programWithFlags
    { init = init
    , view = view
    , update = (\msg model -> withSetStorage (update msg model))
    , subscriptions = \_ -> Sub.none
    }


withSetStorage : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
withSetStorage (model, cmds) =
  ( model, Cmd.batch [ setStorage model, cmds ] )


port setStorage : Model -> Cmd msg
port focus : String -> Cmd msg
