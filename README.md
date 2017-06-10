# Structured TodoMVC in Elm
## OutMsg approach

Different from NoMap, but similar to the OutMsg approach, in this approach besides OutMsg we also has a translator, which is pattern to be followed when a module wants to communicate with its parent or siblings.

This is based on [Alex Lew's blogpost](https://medium.com/@alex.lew/the-translator-pattern-a-model-for-child-to-parent-communication-in-elm-f4bfaa1d3f98).


## Build Instructions

Run the following command from the root of this project:

```bash
elm-make Main.elm --output elm.js
```

Then open `index.html` in your browser!

## Alternatives

- [NoMap approach with Domain focus](https://github.com/rogeriochaves/structured-elm-todomvc/tree/nomap-domain)
- [NoMap approach with Technical focus](https://github.com/rogeriochaves/structured-elm-todomvc/tree/nomap-technical)
- [OutMsg approach](https://github.com/rogeriochaves/structured-elm-todomvc/tree/outmsg)
