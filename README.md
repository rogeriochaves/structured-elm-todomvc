# Structured Modular TodoMVC in Elm

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

This is based on the [official TodoMVC Elm example](https://github.com/evancz/elm-todomvc), but instead of putting all the code in one file, this project has the goal to exemplify how you would break that file in different modules to create your app structure, always following [The Elm Architecture](https://github.com/evancz/elm-architecture-tutorial).

## Project Structure

In this structure, we have the main folder for the app, called TodoApp, which holds the main Action, Model and Views.

Each module inside is composed the same way, we have Control, Task and TaskList, each one with their own Action, Model, and Views.

The TodoApp combines all other modules, e.g. the App.Update is a combination of all other Updates in the project, the App.Model is a combination of all other models in the project, and so on.

Finally, the root main file, called Todo.elm, uses the TodoApp Update, the TodoApp Model and the TodoApp View to start your app.

<a href="https://github.com/rogeriochaves/structured-elm-todomvc" style="font-size:22px">Checkout the non-modularized alternative too</a>

## Build Instructions

Run the following command from the root of this project:

```bash
elm-make Todo.elm --output elm.js
```

Then open `index.html` in your browser!
