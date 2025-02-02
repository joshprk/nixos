{pkgs, ...}: let
  dir = "$HOME/.local/share/gaming";
in {
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraBwrapArgs = [
        "--bind ${dir} $HOME"
        "--unsetenv XDG_CACHE_HOME"
        "--unsetenv XDG_CONFIG_HOME"
        "--unsetenv XDG_DATA_HOME"
        "--unsetenv XDG_STATE_HOME"
      ];
    };
  };
}
