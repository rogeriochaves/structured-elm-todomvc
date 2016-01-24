module Action.TaskList where

type Action
    = Add Int String
    | Delete Int
    | DeleteComplete
    | CheckAll Bool
    | ChangeVisibility String
