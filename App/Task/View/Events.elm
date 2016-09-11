module Task.View.Events exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json


onEnter : msg -> msg -> Attribute msg
onEnter fail success =
    let
        tagger code =
            if code == 13 then
                success
            else
                fail
    in
        on "keyup" (Json.map tagger keyCode)
