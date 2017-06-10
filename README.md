# Structured TodoMVC in Elm
## OutMsg approach

Different from NoMap, in this approach we have an extra type of Msgs, OutMsg, for when a module wants to communicate with its parent or siblings.

This is based on [Folkertdev's blogpost](http://folkertdev.nl/blog/elm-child-parent-communication/).


## Build Instructions

Run the following command from the root of this project:

```bash
elm-make Main.elm --output elm.js
```

Then open `index.html` in your browser!

## Alternatives

- [NoMap approach with Domain focus](https://github.com/rogeriochaves/structured-elm-todomvc/tree/nomap-domain)
- [NoMap approach with Technical focus](https://github.com/rogeriochaves/structured-elm-todomvc/tree/nomap-technical)
- [Translator approach](https://github.com/rogeriochaves/structured-elm-todomvc/tree/translator)
