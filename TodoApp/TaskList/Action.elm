module TodoApp.TaskList.Action where

type Action
    = Add Int String
    | Delete Int
    | DeleteComplete
    | CheckAll Bool
