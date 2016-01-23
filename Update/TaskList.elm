module Update.TaskList where

import Action.TaskList exposing (..)
import Model.TaskList exposing (Model)
import Model.Task exposing (newTask)
import String

update : Action -> Model -> Model
update action model =
    case action of
      NoOp -> model

      Add ->
          { model |
              uid = model.uid + 1,
              field = "",
              tasks =
                  if String.isEmpty model.field
                    then model.tasks
                    else model.tasks ++ [newTask model.field model.uid]
          }

      UpdateField str ->
          { model | field = str }

      EditingTask id isEditing ->
          let updateTask t = if t.id == id then { t | editing = isEditing } else t
          in
              { model | tasks = List.map updateTask model.tasks }

      UpdateTask id task ->
          let updateTask t = if t.id == id then { t | description = task } else t
          in
              { model | tasks = List.map updateTask model.tasks }

      Delete id ->
          { model | tasks = List.filter (\t -> t.id /= id) model.tasks }

      DeleteComplete ->
          { model | tasks = List.filter (not << .completed) model.tasks }

      Check id isCompleted ->
          let updateTask t = if t.id == id then { t | completed = isCompleted } else t
          in
              { model | tasks = List.map updateTask model.tasks }

      CheckAll isCompleted ->
          let updateTask t = { t | completed = isCompleted }
          in
              { model | tasks = List.map updateTask model.tasks }

      ChangeVisibility visibility ->
          { model | visibility = visibility }
