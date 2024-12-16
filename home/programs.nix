{
  config,
  pkgs,
  ...
} @ inputs: {
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    brightnessctl
    wl-clipboard
    mpvpaper
    mpv

    inputs.ghostty.packages.${pkgs.system}.default
  ];

  home.file."${config.xdg.configHome}/ghostty/config" = {
    enable = true;
    target = "${config.xdg.configHome}/ghostty/config";
    text = ''
      window-decoration = false
    '';
  };

  programs.ags = {
    enable = true;
    configDir = ../astal;

    extraPackages = with pkgs; let
      astalPkgs = inputs.ags.packages.${pkgs.system};
    in [
      astalPkgs.battery
    ];
  };

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

  programs.ripgrep = {
    enable = true;
    arguments = [];
  };

  programs.mpv = {
    enable = true;
    config = {
      vo = "kitty";
      vo-kitty-use-shm = "yes";
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "Default";
      theme_background = false;
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

      if [[ $1 == eval ]]
      then
        "$@"
      set --
      fi

      develop() {
        nix develop $1 -c $SHELL -ais eval "export SHELL=$SHELL"
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
