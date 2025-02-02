{pkgs, ...}: let
  dir = "$HOME/.local/share/gaming";
  extraBwrapArgs = [
    "--bind ${dir} $HOME"
    "--unsetenv XDG_CACHE_HOME"
    "--unsetenv XDG_CONFIG_HOME"
    "--unsetenv XDG_DATA_HOME"
    "--unsetenv XDG_STATE_HOME"
  ];
in {
  environment.systemPackages = with pkgs; [
    (lutris.override {
      buildFHSEnv = prev: buildFHSEnv ({
        inherit extraBwrapArgs;
      } // prev);
    })
  ];

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      inherit extraBwrapArgs;
    };
  };
}
