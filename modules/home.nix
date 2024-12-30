{
  config,
  lib,
  pkgs,
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
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBCBom//Vs1SSCBq9JxLloFZEBmkrZ81utid4eg3PfTe joshua@PC"
      ];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bk";
    users.joshua = import ../home;
  };

  environment.sessionVariables = {
    CUDA_CACHE_PATH = "$HOME/.cache/nv";
  };

  programs.zsh.enable = true;
  time.timeZone = "America/New_York";

  nix.settings = {
    use-xdg-base-directories = true;
    extra-experimental-features = ["nix-command" "flakes"];
    trusted-users = ["@root" "@wheel"];
  };
}
