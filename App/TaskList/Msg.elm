module TaskList.Msg exposing (..)


type Msg
    = Add Int String
    | Delete Int
    | DeleteComplete
    | CheckAll Bool
