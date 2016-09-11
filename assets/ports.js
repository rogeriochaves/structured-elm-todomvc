(function() {
  var storedState = localStorage.getItem('elm-app-state');
  console.log('storedState', storedState);
  var startingState = storedState ? JSON.parse(storedState) : null;
  console.log('Elm:', Elm)
  var app = Elm.Main.fullscreen(startingState);
  app.ports.focus.subscribe(function(selector) {
    setTimeout(function() {
      var nodes = document.querySelectorAll(selector);
      if (nodes.length === 1 && document.activeElement !== nodes[0]) {
          nodes[0].focus();
      }
    }, 50);
  });
  app.ports.setStorage.subscribe(function(state) {
      localStorage.setItem('elm-app-state', JSON.stringify(state));
  });
})();