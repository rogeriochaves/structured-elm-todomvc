# Structured TodoMVC in Elm
## NoMap approach with Technical focus

This is based on the [official TodoMVC Elm example](https://github.com/evancz/elm-todomvc), but instead of putting all the code in one file, this project has the goal to exemplify how you would break that file in different modules to create your app structure, always following [The Elm Architecture](https://github.com/evancz/elm-architecture-tutorial).

## Project Structure

We have four main folders: Msg, Model, Update and View.

Each one of those folders have a Main.elm file, which combines all other modules, e.g. the Update.Main is a combination of all other Updates in the project, the Model.Main is a combination of all other models in the project, and so on.

Finally, the root main file, called Main.elm, uses the Main Update, the Main Model and the Main View to start your app.

In this approach, we avoid using Cmd.map and Html.map, instead all Updates can change their own models based on Msg from others, and the Views can send Msgs to anyone.

## Build Instructions

Run the following command from the root of this project:

```bash
elm-make Main.elm --output elm.js
```

Then open `index.html` in your browser!

## Alternatives

- [NoMap approach with Domain focus](https://github.com/rogeriochaves/structured-elm-todomvc/tree/nomap-domain)
- [OutMsg approach](https://github.com/rogeriochaves/structured-elm-todomvc/tree/outmsg)
- [Translator approach](https://github.com/rogeriochaves/structured-elm-todomvc/tree/translator)
