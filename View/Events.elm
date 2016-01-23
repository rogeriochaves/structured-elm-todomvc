module View.Events where

import Html exposing (..)
import Html.Events exposing (..)
import Signal exposing (Address)
import Json.Decode as Json

onEnter : Address a -> a -> Attribute
onEnter address value =
    on "keydown"
      (Json.customDecoder keyCode is13)
      (\_ -> Signal.message address value)

is13 : Int -> Result String ()
is13 code =
  if code == 13 then Ok () else Err "not the right key code"
