module Control exposing (..)


type alias Model =
    { visibility : String
    }


model : Model
model =
    { visibility = "All"
    }


type Msg
    = ChangeVisibility String
    | DeleteComplete


type OutMsg
    = NoOp
    | TodoListDeleteComplete


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeVisibility visibility ->
            { model | visibility = visibility }

        DeleteComplete ->
            model
