module TodoApp.View.Task.TodoItem exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import TodoApp.Task as Task exposing (Msg(..))
import TodoApp.TaskList exposing (..)
import TodoApp.View.Task.Events exposing (onEnter)


todoItem : Task.Model -> Html TodoApp.TaskList.Msg
todoItem todo =
    li [ classList [ ( "completed", todo.completed ), ( "editing", todo.editing ) ] ]
        [ div [ class "view" ]
            [ input
                [ class "toggle"
                , type_ "checkbox"
                , checked todo.completed
                , onClick (MsgForTask todo.id <| Check (not todo.completed))
                ]
                []
            , label [ onDoubleClick (MsgForTask todo.id <| Editing True) ]
                [ text todo.description ]
            , button
                [ class "destroy"
                , onClick (Delete todo.id)
                ]
                []
            ]
        , input
            [ class "edit"
            , value todo.description
            , name "title"
            , id ("todo-" ++ toString todo.id)
            , on "input" (Json.map (MsgForTask todo.id << Update) targetValue)
            , onBlur (MsgForTask todo.id <| Editing False)
            , onEnter TodoApp.TaskList.NoOp (MsgForTask todo.id <| Editing False)
            ]
            []
        ]
