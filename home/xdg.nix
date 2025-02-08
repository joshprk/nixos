{
  config,
  ...
}: {
  xdg = {
    enable = true;
    mime.enable = true;
    userDirs.createDirectories = false;

    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = ["zen.desktop"];
        "application/octet-stream" = ["nvim.desktop"];
        "application/x-zerosize" = ["nvim.desktop"];
        "text/plain" = ["nvim.desktop"];
      };
    };
  };

  home.file = {
    ".icons/default/index.theme".enable = false;
    ".icons/${config.home.pointerCursor.name}".enable = false;
    ".themes/adw-gtk3".enable = false;
  };

  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    ERRFILE = "${config.xdg.cacheHome}/x11/xsession-errors";
    XCOMPOSECACHE = "${config.xdg.cacheHome}/x11/xcompose";
    IPYTHONDIR = "${config.xdg.configHome}/ipython";

    BROWSER = "zen";
    TERMINAL = "ghostty";
  };

  gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  xresources.path = "${config.xdg.configHome}/x11/resources";
}
