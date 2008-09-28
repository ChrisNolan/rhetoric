// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


//
function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

// From http://macournoyer.wordpress.com/2007/10/11/3-simple-tips-to-make-your-rails-app-100-times-faster/
var CurrentUser = {
  loggedIn: false,
  author: false,
  admin: false,

  init: function() {
    this.loggedIn = readCookie('auth_token') != null;
    this.admin    = readCookie('auth_token') != null; // for now logged in and admin are the same
  }
};

var Application = {
  init: function() {
    CurrentUser.init();
  },

  onBodyLoaded: function() {
    if (CurrentUser.loggedIn) {
      $$('.if_logged_in').invoke('show');
      $$('.unless_logged_in').invoke('hide');
    }
    if (CurrentUser.admin) {
      $$('.if_admin').invoke('show');
    }
  }
};

Application.init();