module Todo where
{-| TodoMVC implemented in Elm, using plain HTML and CSS for rendering.

This application is broken up into four distinct parts:

  1. Model  - a full definition of the application's state
  2. Update - a way to step the application state forward
  3. View   - a way to visualize our application state with HTML
  4. Inputs - the signals necessary to manage events

This clean division of concerns is a core part of Elm. You can read more about
this in the Pong tutorial: http://elm-lang.org/blog/making-pong

This program is not particularly large, so definitely see the following
for notes on structuring more complex GUIs with Elm:
https://github.com/evancz/elm-architecture-tutorial/
-}

import Html exposing (..)
import Signal exposing (Signal, Address)
import Action.TaskList exposing (..)
import Model.TaskList as TaskList exposing (Model)
import Update.TaskList exposing (update)
import View.Main exposing (view)

---- INPUTS ----

-- wire the entire application together
main : Signal Html
main =
  Signal.map (view actions.address) model

initialModel : Model
initialModel =
  Maybe.withDefault TaskList.model getStorage

-- manage the model of our application over time
model : Signal Model
model =
  Signal.foldp update initialModel actions.signal

-- actions from user input
actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp


port focus : Signal String
port focus =
    let needsFocus act =
            case act of
              EditingTask id bool -> bool
              _ -> False

        toSelector act =
            case act of
              EditingTask id _ -> "#todo-" ++ toString id
              _ -> ""
    in
        actions.signal
          |> Signal.filter needsFocus (EditingTask 0 True)
          |> Signal.map toSelector


-- interactions with localStorage to save the model
port getStorage : Maybe Model

port setStorage : Signal Model
port setStorage = model
