module TodoApp.Control.Model where

type alias Model =
    { visibility : String
    }

model : Model
model =
    { visibility = "All"
    }
