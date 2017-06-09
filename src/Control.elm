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
    | DeleteCompleted


type OutMsg
    = OutNoOp
    | TodoListDeleteCompleted


update : Msg -> Model -> ( Model, OutMsg )
update msg model =
    case msg of
        ChangeVisibility visibility ->
            ( { model | visibility = visibility }, OutNoOp )

        DeleteCompleted ->
            ( model, TodoListDeleteCompleted )
