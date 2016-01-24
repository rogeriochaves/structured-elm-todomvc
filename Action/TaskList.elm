module Action.TaskList where

type Action
    = UpdateField String
    | Add
    | Delete Int
    | DeleteComplete
    | CheckAll Bool
    | ChangeVisibility String
