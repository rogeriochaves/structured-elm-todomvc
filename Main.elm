port module Main exposing (..)

import App exposing (Msg, init, updateWithCmd, view, withSetStorage)
import Html
import Model exposing (Model)


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
