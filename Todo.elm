module Todo where
{-| TodoMVC implemented in Elm, using plain HTML and CSS for rendering.

This application is broken up into four distinct parts:

  1. Model  - a full definition of the application's state
  2. Update - a way to step the application state forward
  3. View   - a way to visualize our application state with HTML
  4. Inputs - the signals necessary to manage events

This clean division of concerns is a core part of Elm. You can read more about
this in the Pong tutorial: http://elm-lang.org/blog/making-pong

This program is not particularly large, so definitely see the following
for notes on structuring more complex GUIs with Elm:
https://github.com/evancz/elm-architecture-tutorial/
-}

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Lazy exposing (lazy, lazy2, lazy3)
import Json.Decode as Json
import Signal exposing (Signal, Address)
import StartApp.Simple as StartApp
import Model.Task as Task exposing (newTask)
import Model.TaskList exposing (Model, model)
import Action.TaskList exposing (..)
import Update.TaskList exposing (update)

---- VIEW ----

view : Address Action -> Model -> Html
view address model =
    div
      [ class "todomvc-wrapper"
      , style [ ("visibility", "hidden") ]
      ]
      [ section
          [ id "todoapp" ]
          [ lazy2 taskEntry address model.field
          , lazy3 taskList address model.visibility model.tasks
          , lazy3 controls address model.visibility model.tasks
          ]
      , infoFooter
      ]


onEnter : Address a -> a -> Attribute
onEnter address value =
    on "keydown"
      (Json.customDecoder keyCode is13)
      (\_ -> Signal.message address value)


is13 : Int -> Result String ()
is13 code =
  if code == 13 then Ok () else Err "not the right key code"


taskEntry : Address Action -> String -> Html
taskEntry address task =
    header
      [ id "header" ]
      [ h1 [] [ text "todos" ]
      , input
          [ id "new-todo"
          , placeholder "What needs to be done?"
          , autofocus True
          , value task
          , name "newTodo"
          , on "input" targetValue (Signal.message address << UpdateField)
          , onEnter address Add
          ]
          []
      ]


taskList : Address Action -> String -> List Task.Model -> Html
taskList address visibility tasks =
    let isVisible todo =
            case visibility of
              "Completed" -> todo.completed
              "Active" -> not todo.completed
              _ -> True

        allCompleted = List.all .completed tasks

        cssVisibility = if List.isEmpty tasks then "hidden" else "visible"
    in
    section
      [ id "main"
      , style [ ("visibility", cssVisibility) ]
      ]
      [ input
          [ id "toggle-all"
          , type' "checkbox"
          , name "toggle"
          , checked allCompleted
          , onClick address (CheckAll (not allCompleted))
          ]
          []
      , label
          [ for "toggle-all" ]
          [ text "Mark all as complete" ]
      , ul
          [ id "todo-list" ]
          (List.map (todoItem address) (List.filter isVisible tasks))
      ]


todoItem : Address Action -> Task.Model -> Html
todoItem address todo =
    li
      [ classList [ ("completed", todo.completed), ("editing", todo.editing) ] ]
      [ div
          [ class "view" ]
          [ input
              [ class "toggle"
              , type' "checkbox"
              , checked todo.completed
              , onClick address (Check todo.id (not todo.completed))
              ]
              []
          , label
              [ onDoubleClick address (EditingTask todo.id True) ]
              [ text todo.description ]
          , button
              [ class "destroy"
              , onClick address (Delete todo.id)
              ]
              []
          ]
      , input
          [ class "edit"
          , value todo.description
          , name "title"
          , id ("todo-" ++ toString todo.id)
          , on "input" targetValue (Signal.message address << UpdateTask todo.id)
          , onBlur address (EditingTask todo.id False)
          , onEnter address (EditingTask todo.id False)
          ]
          []
      ]


controls : Address Action -> String -> List Task.Model -> Html
controls address visibility tasks =
    let tasksCompleted = List.length (List.filter .completed tasks)
        tasksLeft = List.length tasks - tasksCompleted
        item_ = if tasksLeft == 1 then " item" else " items"
    in
    footer
      [ id "footer"
      , hidden (List.isEmpty tasks)
      ]
      [ span
          [ id "todo-count" ]
          [ strong [] [ text (toString tasksLeft) ]
          , text (item_ ++ " left")
          ]
      , ul
          [ id "filters" ]
          [ visibilitySwap address "#/" "All" visibility
          , text " "
          , visibilitySwap address "#/active" "Active" visibility
          , text " "
          , visibilitySwap address "#/completed" "Completed" visibility
          ]
      , button
          [ class "clear-completed"
          , id "clear-completed"
          , hidden (tasksCompleted == 0)
          , onClick address DeleteComplete
          ]
          [ text ("Clear completed (" ++ toString tasksCompleted ++ ")") ]
      ]


visibilitySwap : Address Action -> String -> String -> String -> Html
visibilitySwap address uri visibility actualVisibility =
    li
      [ onClick address (ChangeVisibility visibility) ]
      [ a [ href uri, classList [("selected", visibility == actualVisibility)] ] [ text visibility ] ]


infoFooter : Html
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


---- INPUTS ----

-- wire the entire application together
main : Signal Html
main =
  StartApp.start { model = model, view = view, update = update }

model : Model
model =
  Maybe.withDefault model getStorage

-- interactions with localStorage to save the model
port getStorage : Maybe Model

port setStorage : Model
port setStorage = model
