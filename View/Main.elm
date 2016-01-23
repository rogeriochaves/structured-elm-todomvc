module View.Main where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Lazy exposing (lazy, lazy2, lazy3)
import Action.TaskList exposing (..)
import Signal exposing (Address)
import Model.TaskList exposing (Model)
import View.TaskList.Main exposing (taskList)
import View.TaskEntry exposing (taskEntry)
import View.Controls as Controls
import View.InfoFooter exposing (infoFooter)

view : Address Action -> Model -> Html
view address model =
    div
      [ class "todomvc-wrapper"
      , style [ ("visibility", "hidden") ]
      ]
      [ section
          [ id "todoapp" ]
          [ lazy2 taskEntry address model.field
          , lazy3 taskList address model.visibility model.tasks
          , lazy3 Controls.controls address model.visibility model.tasks
          ]
      , infoFooter
      ]
