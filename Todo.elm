port module Todo exposing (..)

import Html
import TodoApp.Msg exposing (Msg)
import TodoApp.Update exposing (Model, init, updateWithCmd, view, withSetStorage)


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
