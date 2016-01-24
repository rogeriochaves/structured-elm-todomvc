module TodoApp.Task.Action where

type Action
    = Check Bool
    | Editing Bool
    | Update String
