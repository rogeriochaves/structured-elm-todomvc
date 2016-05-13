module Model.Control exposing (..)

type alias Model =
    { visibility : String
    }

model : Model
model =
    { visibility = "All"
    }
