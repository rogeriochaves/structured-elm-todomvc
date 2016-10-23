port module Todo exposing (..)

import Html.App as App
import TodoApp.Model exposing (Model, init, withSetStorage)
import TodoApp.View.TodoApp exposing (view)
import TodoApp.Update exposing (updateWithCmd)


main : Program (Maybe Model)
main =
    App.programWithFlags
        { init = init
        , view = view
        , update = (\msg model -> withSetStorage setStorage (updateWithCmd msg model))
        , subscriptions = \_ -> Sub.none
        }


port setStorage : Model -> Cmd msg
