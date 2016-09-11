(function() {
  var storedState = localStorage.getItem('elm-app-state');
  var startingState = storedState ? JSON.parse(storedState) : null;
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