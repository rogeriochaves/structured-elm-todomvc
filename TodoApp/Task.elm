module TodoApp.Task exposing (..)


type alias Model =
    { description : String
    , completed : Bool
    , editing : Bool
    , id : Int
    }


newTask : Int -> String -> Model
newTask id description =
    { description = description
    , completed = False
    , editing = False
    , id = id
    }


model : Model
model =
    newTask 1 ""


type Msg
    = NoOp
    | Check Bool
    | Editing Bool
    | Update String
    | Add Int String


type OutMsg
    = OutNoOp
    | TaskListAdd Int String


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
            ( newTask id "", TaskListAdd id description )
