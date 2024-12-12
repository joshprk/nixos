{
  config,
  pkgs,
  ...
} @ inputs: {
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    brightnessctl
    swww
    
    python313
    ripgrep
  ];

  systemd.user.services.swww-daemon = {
    Unit = {
      Description = "Starts swww daemon";
      After = ["graphical-session-pre.target"];
      PartOf = ["graphical-session.target"];
    };

    Install = { WantedBy = ["graphical-session.target"]; };
    Service = { ExecStart = "${pkgs.swww}/bin/swww-daemon"; };
  };

  programs.alacritty = {
    enable = true;
    settings = {};
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
