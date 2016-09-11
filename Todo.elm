port module Todo exposing (..)

import Html.App as App
import App.Model exposing (Model, init, withSetStorage)
import App.Templates.Application exposing (view)
import App.Update exposing (updateWithCmd)


main : Program (Maybe Model)
main =
    App.programWithFlags
        { init = init
        , view = view
        , update = (\msg model -> withSetStorage setStorage (updateWithCmd focus msg model))
        , subscriptions = \_ -> Sub.none
        }


port setStorage : Model -> Cmd msg


port focus : String -> Cmd msg
