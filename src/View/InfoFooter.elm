module View.InfoFooter exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (Msg)


infoFooter : Html Msg
infoFooter =
    footer [ id "info" ]
        [ p [] [ text "Double-click to edit a todo" ]
        , p []
            [ text "Written by "
            , a [ href "https://github.com/evancz" ] [ text "Evan Czaplicki" ]
            ]
        , p []
            [ text "Part of "
            , a [ href "http://todomvc.com" ] [ text "TodoMVC" ]
            ]
        ]
