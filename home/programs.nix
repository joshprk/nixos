{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    astal
    brightnessctl
    zen-browser
  ];

  programs.btop = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--bind 'ctrl-j:down,ctrl-k:up,alt-j:preview-down,alt-k:preview-up'"
    ];
  };

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      window-decoration = false;
      gtk-single-instance = true;
      theme = "catppuccin-mocha";
    };
  };

  programs.git = {
    enable = true;
    userEmail = "joshuprk@gmail.com";
    userName = "Joshua Park";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.mpv = {
    enable = true;
    config = {
      vo = "kitty";
      vo-kitty-use-shm = "yes";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
    history.path = "${config.xdg.dataHome}/zsh/zsh_history";
    initExtraFirst = ''
      if uwsm check may-start && uwsm select; then
        exec systemd-cat -t uwsm_start uwsm start default
      fi
    '';
    initExtra = ''
      autoload -U colors && colors
      export PS1="%B%{$fg[green]%}[%n@%m:%~]$%b%{$reset_color%} "
    '';
    completionInit = ''
      autoload -U compinit
      [ -d ${config.xdg.cacheHome}/zsh ] || mkdir -p ${config.xdg.cacheHome}/zsh
      zstyle ':completion:*' cache-path ${config.xdg.cacheHome}/zsh/zcompcache
      compinit -d ${config.xdg.cacheHome}/zsh/zcompdump
    '';
  };
}
