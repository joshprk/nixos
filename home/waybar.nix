{...}: {
  programs.waybar = {
    enable = true;

    settings = {
      main-bar = {
        layer = "top";
        position = "top";
        height = 30;

        modules-left = [];
        modules-center = [];
        modules-right = [];
      };
    };

    style = ''

    '';
  };
}
