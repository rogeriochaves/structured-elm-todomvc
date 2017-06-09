port module Todo exposing (..)

import Html
import TodoApp.Model exposing (Model, init, withSetStorage)
import TodoApp.Msg exposing (Msg)
import TodoApp.Update exposing (updateWithCmd)
import TodoApp.View.TodoApp exposing (view)


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
