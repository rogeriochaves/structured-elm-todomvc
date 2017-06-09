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



-- update : Main.Msg -> Model -> Model
-- update msgFor task =
--     case msgFor of
--         MsgForTaskEntry msg ->
--             updateTask msg task
--
--         MsgForTask _ msg ->
--             updateTask msg task
--
--         MsgForTaskList (Add id _) ->
--             newTask (id + 1) ""
--
--         _ ->
--             task


update : Msg -> Model -> Model
update msg model =
    case msg of
        Check isCompleted ->
            { model | completed = isCompleted }

        Editing isEditing ->
            { model | editing = isEditing }

        Update description ->
            { model | description = description }
