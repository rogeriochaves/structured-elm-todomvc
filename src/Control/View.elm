module Control.View exposing (..)

import Control.Update exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Todo.Model as Todo


controls : String -> List Todo.Model -> Html Msg
controls visibility todos =
    let
        todosCompleted =
            List.length (List.filter .completed todos)

        todosLeft =
            List.length todos - todosCompleted

        item_ =
            if todosLeft == 1 then
                " item"
            else
                " items"
    in
    footer
        [ id "footer"
        , hidden (List.isEmpty todos)
        ]
        [ span [ id "todo-count" ]
            [ strong [] [ text (toString todosLeft) ]
            , text (item_ ++ " left")
            ]
        , ul [ id "filters" ]
            [ visibilitySwap "#/" "All" visibility
            , text " "
            , visibilitySwap "#/active" "Active" visibility
            , text " "
            , visibilitySwap "#/completed" "Completed" visibility
            ]
        , button
            [ class "clear-completed"
            , id "clear-completed"
            , hidden (todosCompleted == 0)
            , onClick (ForSelf DeleteCompleted)
            ]
            [ text ("Clear completed (" ++ toString todosCompleted ++ ")") ]
        ]


visibilitySwap : String -> String -> String -> Html Msg
visibilitySwap uri visibility actualVisibility =
    li [ onClick (ForSelf <| ChangeVisibility visibility) ]
        [ a [ href uri, classList [ ( "selected", visibility == actualVisibility ) ] ] [ text visibility ] ]
