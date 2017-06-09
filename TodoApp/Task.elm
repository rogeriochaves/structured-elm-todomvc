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
    = Check Bool
    | Editing Bool
    | Update String
    | New Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        Check isCompleted ->
            { model | completed = isCompleted }

        Editing isEditing ->
            { model | editing = isEditing }

        Update description ->
            { model | description = description }

        New id ->
            newTask id ""
