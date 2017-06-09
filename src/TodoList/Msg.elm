module TodoList.Msg exposing (..)


type Msg
    = Add Int String
    | Delete Int
    | DeleteCompleted
    | CheckAll Bool
