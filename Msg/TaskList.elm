module Msg.TaskList exposing (..)

type Msg
    = Add Int String
    | Delete Int
    | DeleteComplete
    | CheckAll Bool
