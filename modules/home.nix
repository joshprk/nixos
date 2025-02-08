{
  config,
  pkgs,
  home,
  ...
}: {
  environment.sessionVariables = {
    CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
  };

  users.mutableUsers = false;
  users.defaultUserShell = pkgs.zsh;
  users.users = {
    root = {
      hashedPasswordFile = config.age.secrets.user.path;
    };

    joshua = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager"];
      hashedPasswordFile = config.age.secrets.user.path;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = home;
    users = {
      joshua = import ../home;
    };
  };

  programs.dconf = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
  };

  nix.settings = {
    use-xdg-base-directories = true;
  };

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = ["com.mitchellh.ghostty"];
    };
  };
}
