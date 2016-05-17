# Structured TodoMVC in Elm

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

This is based on the [official TodoMVC Elm example](https://github.com/evancz/elm-todomvc), but instead of putting all the code in one file, this project has the goal to exemplify how you would break that file in different modules to create your app structure, always following [The Elm Architecture](https://github.com/evancz/elm-architecture-tutorial).

## Project Structure

We have four main folders: Action, Model, Update and View.

Each one of those folders have a Main.elm file, which combines all other modules, e.g. the TodoApp.Update  is a combination of all other Updates in the project, the TodoApp.Main.Model is a combination of all other models in the project, and so on.

Finally, the root main file, called Todo.elm, uses the Main Update, the Main Model and the Main View to start your app.

<a href="https://github.com/rogeriochaves/structured-elm-todomvc/tree/modular" style="font-size:22px">Checkout the modularized alternative too</a>

## Build Instructions

Run the following command from the root of this project:

```bash
elm-make Todo.elm --output elm.js
```

Then open `index.html` in your browser!
