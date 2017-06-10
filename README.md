# Structured TodoMVC in Elm
## NoMap approach with Domain focus

In this structure, our src folder holds the main Msg, Update, Model and Views, and each module inside it is composed the same way. We have Control, Todo and TodoList, each one with their own Msg, Update, Model, and Views.

The top-level modules combines all other modules, e.g. src/Update is a combination of all other Updates in the project, src/Model is a combination of all other models in the project, and so on.

Finally, the root main file, called Main.elm, uses the main Update, Model and the View to start your app.

In this approach, we avoid using Cmd.map and Html.map, instead all Updates can change their own models based on Msg from others, and the Views can send Msgs to anyone.

## Build Instructions

Run the following command from the root of this project:

```bash
elm-make Main.elm --output elm.js
```

Then open `index.html` in your browser!

## Alternatives

- [NoMap approach with Technical focus](https://github.com/rogeriochaves/structured-elm-todomvc/tree/nomap-technical)
- [OutMsg approach](https://github.com/rogeriochaves/structured-elm-todomvc/tree/outmsg)
- [Translator approach](https://github.com/rogeriochaves/structured-elm-todomvc/tree/translator)
