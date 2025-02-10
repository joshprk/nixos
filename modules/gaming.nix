{
  lib,
  pkgs,
  ...
}: let
  mkSandbox = {
    name,
    package,
    ...
  }: pkgs.buildFHSEnv {
    inherit (package) passthru;
    inherit name;

    targetPkgs = _: [package];
    
    runScript = name;
    mainProgram = lib.getExe package;

    chdirToPwd = false;
    dieWithParent = true;

    extraBwrapArgs = [
      "--bind $XDG_DATA_HOME/gaming $HOME"
      "--chdir $HOME"
      "--dir $HOME"
      "--dir XDG_CACHE_HOME"
      "--dir XDG_CONFIG_HOME"
      "--dir XDG_DATA_HOME"
      "--dir XDG_STATE_HOME"
    ];
  };

  mkOverridableSandbox = lib.makeOverridable mkSandbox;
in {
  environment.systemPackages = with pkgs; [
    (mkSandbox {
      name = "lutris";
      package = lutris;
    })

    (mkSandbox {
      name = "protonup";
      package = protonup;
    })
  ];

  programs.steam = {
    enable = true;
    package = mkOverridableSandbox {
      name = "steam";
      package = pkgs.steam;
    };
  };
}

