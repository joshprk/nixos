{
  config,
  pkgs,
  system,
  ...
} @ inputs: {
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    users.joshua = {
      isNormalUser = true;
      useDefaultShell = true;
      extraGroups = ["wheel" "networkmanager"];
      hashedPasswordFile = config.age.secrets.user.path;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = with inputs; [
      nixvim.homeManagerModules.nixvim
    ];

    users.joshua = import ../home;
  };

  programs.zsh.enable = true;

  time.timeZone = "America/New_York";

  nix.settings = {
    use-xdg-base-directories = true;
    extra-experimental-features = ["nix-command" "flakes"];
  };
}
