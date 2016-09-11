port module Main exposing (..)

import Html.App as HtmlApp
import Model exposing (Model, init, withSetStorage)
import Templates.Application exposing (view)
import Update exposing (updateWithCmd)


main : Program (Maybe Model)
main =
    HtmlApp.programWithFlags
        { init = init
        , view = view
        , update = (\msg model -> withSetStorage setStorage (updateWithCmd focus msg model))
        , subscriptions = \_ -> Sub.none
        }


port setStorage : Model -> Cmd msg


port focus : String -> Cmd msg
