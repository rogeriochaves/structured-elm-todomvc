port module Todo exposing (..)

import Html.App as App
import Model.Main exposing (Model, init, withSetStorage)
import View.Main exposing (view)
import Update.Main exposing (update)


main : Program (Maybe Model)
main =
    App.programWithFlags
        { init = init
        , view = view
        , update = (\msg model -> withSetStorage setStorage (update focus msg model))
        , subscriptions = \_ -> Sub.none
        }


port setStorage : Model -> Cmd msg


port focus : String -> Cmd msg
