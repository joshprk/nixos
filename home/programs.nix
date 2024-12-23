{
  config,
  pkgs,
  ...
} @ inputs: {
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    brightnessctl
    wl-clipboard
    hyprshot

    inputs.zen-browser.packages.${pkgs.system}.specific
    inputs.ghostty.packages.${pkgs.system}.default
  ];

  services.mako = {
    enable = true;
  };

  xdg.configFile.ghostty = {
    enable = true;
    target = "ghostty/config";
    text = ''
      window-decoration = false
      window-padding-x = 4
      window-padding-y = 4

      gtk-single-instance = true

      palette = 0=#494d64
      palette = 1=#ed8796
      palette = 2=#a6da95
      palette = 3=#eed49f
      palette = 4=#8aadf4
      palette = 5=#f5bde6
      palette = 6=#8bd5ca
      palette = 7=#b8c0e0
      palette = 8=#5b6078
      palette = 9=#ed8796
      palette = 10=#a6da95
      palette = 11=#eed49f
      palette = 12=#8aadf4
      palette = 13=#f5bde6
      palette = 14=#8bd5ca
      palette = 15=#a5adcb
      background = 24273a
      foreground = cad3f5
      cursor-color = f4dbd6
      selection-background = 3a3e53
      selection-foreground = cad3f5
    '';
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

  programs.rofi = {
    enable = true;
    extraConfig = {
      hover-select = true;
      terminal = "ghostty";
      me-select-entry = "";
      me-accept-entry = [ "MousePrimary" "MouseSecondary" "MouseDPrimary" ];
    };
  };

  programs.ranger = {
    enable = true;
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
