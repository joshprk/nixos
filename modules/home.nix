{
  config,
  pkgs,
  home,
  ...
}: {
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

  programs.zsh = {
    enable = true;
  };

  nix.settings = {
    use-xdg-base-directories = true;
  };
}
