port module Main exposing (..)

import Html
import Model exposing (Model, init, withSetStorage)
import Msg exposing (Msg)
import Update exposing (updateWithCmd)
import View.TodoApp exposing (view)


main : Program (Maybe Model) Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = \msg model -> withSetStorage setStorage (updateWithCmd focus msg model)
        , subscriptions = \_ -> Sub.none
        }


port setStorage : Model -> Cmd msg


port focus : String -> Cmd msg
