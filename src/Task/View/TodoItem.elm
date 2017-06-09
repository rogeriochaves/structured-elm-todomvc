module Task.View.TodoItem exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Msg as Main exposing (..)
import Task.Model as Task
import Task.Msg exposing (..)
import Task.View.Events exposing (onEnter)
import TaskList.Msg exposing (..)


todoItem : Task.Model -> Html Main.Msg
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
                , onClick (MsgForTaskList <| Delete todo.id)
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
            , onEnter NoOp (MsgForTask todo.id <| Editing False)
            ]
            []
        ]
