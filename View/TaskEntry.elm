module View.TaskEntry where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Action.TaskList exposing (..)
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

taskEntry : Address Action -> String -> Html
taskEntry address task =
    header
      [ id "header" ]
      [ h1 [] [ text "todos" ]
      , input
          [ id "new-todo"
          , placeholder "What needs to be done?"
          , autofocus True
          , value task
          , name "newTodo"
          , on "input" targetValue (Signal.message address << UpdateField)
          , onEnter address Add
          ]
          []
      ]
