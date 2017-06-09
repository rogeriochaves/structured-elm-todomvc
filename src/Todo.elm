module Todo exposing (..)


type alias Model =
    { description : String
    , completed : Bool
    , editing : Bool
    , id : Int
    }


newTodo : Int -> String -> Model
newTodo id description =
    { description = description
    , completed = False
    , editing = False
    , id = id
    }


model : Model
model =
    newTodo 1 ""


type Msg
    = NoOp
    | Check Bool
    | Editing Bool
    | Update String
    | Add Int String


type OutMsg
    = OutNoOp
    | TodoListAdd Int String


update : Msg -> Model -> ( Model, OutMsg )
update msg model =
    case msg of
        NoOp ->
            ( model, OutNoOp )

        Check isCompleted ->
            ( { model | completed = isCompleted }, OutNoOp )

        Editing isEditing ->
            ( { model | editing = isEditing }, OutNoOp )

        Update description ->
            ( { model | description = description }, OutNoOp )

        Add id description ->
            ( newTodo id "", TodoListAdd id description )
