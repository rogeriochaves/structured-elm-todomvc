module Update.Control exposing (..)

import Model.Control exposing (Model)
import Msg.Control as Control exposing (..)


update : Control.Msg -> Model -> Model
update msg model =
    case msg of
        ChangeVisibility visibility ->
            { model | visibility = visibility }
