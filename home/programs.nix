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
    nautilus

    inputs.hyprland-qtutils.packages.${pkgs.system}.default
    inputs.zen-browser.packages.${pkgs.system}.specific
    inputs.ghostty.packages.${pkgs.system}.default
  ];

  services.swaync = {
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

      palette = 0=#45475a
      palette = 1=#f38ba8
      palette = 2=#a6e3a1
      palette = 3=#f9e2af
      palette = 4=#89b4fa
      palette = 5=#f5c2e7
      palette = 6=#94e2d5
      palette = 7=#bac2de
      palette = 8=#585b70
      palette = 9=#f38ba8
      palette = 10=#a6e3a1
      palette = 11=#f9e2af
      palette = 12=#89b4fa
      palette = 13=#f5c2e7
      palette = 14=#94e2d5
      palette = 15=#a6adc8
      background = 1e1e2e
      foreground = cdd6f4
      cursor-color = f5e0dc
      selection-background = 353749
      selection-foreground = cdd6f4
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
      me-accept-entry = [
      	"MousePrimary"
	"MouseSecondary"
	"MouseDPrimary"
      ];
    };
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
