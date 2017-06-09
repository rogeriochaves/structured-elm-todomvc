module TodoApp.View.Task.TodoItem exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import TodoApp.Msg as Main exposing (..)
import TodoApp.Task as Task exposing (..)
import TodoApp.TaskList exposing (..)
import TodoApp.View.Task.Events exposing (onEnter)


todoItem : Task.Model -> Html Main.Msg
todoItem todo =
    li [ classList [ ( "completed", todo.completed ), ( "editing", todo.editing ) ] ]
        [ div [ class "view" ]
            [ input
                [ class "toggle"
                , type_ "checkbox"
                , checked todo.completed
                , onClick (MsgForTaskList <| MsgForTask todo.id <| Check (not todo.completed))
                ]
                []
            , label [ onDoubleClick (MsgForTaskList <| MsgForTask todo.id <| Editing True) ]
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
            , on "input" (Json.map (MsgForTaskList << MsgForTask todo.id << Update) targetValue)
            , onBlur (MsgForTaskList <| MsgForTask todo.id <| Editing False)
            , onEnter Main.NoOp (MsgForTaskList <| MsgForTask todo.id <| Editing False)
            ]
            []
        ]
