port module Todo exposing (..)

import Html
import Model.Main exposing (Model, init, withSetStorage)
import Msg.Main exposing (Msg)
import Update.Main exposing (updateWithCmd)
import View.Main exposing (view)


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
