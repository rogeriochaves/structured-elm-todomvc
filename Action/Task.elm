module Action.Task where

type Action
    = Check Bool
    | Editing Bool
    | Update String
