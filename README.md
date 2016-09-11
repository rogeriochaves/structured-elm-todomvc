# ELMBER

> Elm TodoMVC with a modular/Ember pods-style directory structure

This is based on [rogeriochaves/structured-elm-todomvc/tree/MODULAR](https://github.com/rogeriochaves/structured-elm-todomvc/tree/modular)
which is based on the [Official Elm TodoMVC](https://github.com/evancz/elm-todomvc),
but instead of putting all the code in one giant ass 400 line file, the code is broken up 
in a Modular style like pods in Ember. In this fork I've made a few more minor
adjustments to make an Ember user feel more at home.

This follows [The Elm Architecture](https://github.com/evancz/elm-architecture-tutorial).

The web root is the root of the repo, unfortunately I (@DevinRhode2) had a hard time 
teasing apart these two.. it might require starting `elm reactor` from the `App` directory,
which I would rather not do. I moved all the elm app source into the `App` folder.

The `App/Templates` folder is very akin to the `app/templates` folder in Ember.
`App/Templates/Application.elm` corresponds to your typical application template.

`App/Main.elm` pulls in `App/Model.elm`, `App/Update.elm` and `App/View.elm` to start 
the app with `Html.App.programWithFlags`.

• `App/Update.elm` is a combination of all other Updates in the project
• `App/Model.elm` is a combination of all other Models in the project
• and so on..

The `Control`, `Task`, and `TaskList` ..um modules/'container components?' are all 
composed in the same way, each one with it's own `Model`, `Msg`, `Update` files 
and a `View` folder with respective template file(s).

## Build Instructions

Run the build command in elm-package.json (look for `elm make ...`)

Then open `index.html` in your browser!

Apparently this button will deploy this project to heroku?

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)
