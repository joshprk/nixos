{
  config,
  pkgs,
  ...
} @ inputs: {
  programs.alacritty.enable = true;

  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      DontCheckDefaultBrowser = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "Joshua Park";
    userEmail = "joshuprk@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
    history.path = "${config.xdg.dataHome}/zsh/history";

    initExtra = ''
      autoload -U colors && colors
      PS1="%B%{$fg[green]%}[%n@%m:%~]$%{$reset_color%}%b "

      develop() {
        nix develop $1 -c $SHELL
      }
    '';

    completionInit = ''
      autoload -U compinit
      compinit -d ${config.xdg.dataHome}/zsh/compdump
    '';

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
  };
}
