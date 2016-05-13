port module Todo exposing (..)

import Html exposing (..)
import Html.App as App
import Msg.Main exposing (..)
import Model.Main exposing (Model, init)
import View.Main exposing (view)
import Update.Main exposing (update)


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
