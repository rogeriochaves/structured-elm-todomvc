module Update.Task where

import Action.Task as Task exposing (..)
import Model.Task exposing (Model, newTask)

update : Task.Action -> Model -> Model
update action model =
    case action of
      Check isCompleted ->
        { model | completed = isCompleted }

      Editing isEditing ->
        { model | editing = isEditing }

      Update description ->
        { model | description = description }
