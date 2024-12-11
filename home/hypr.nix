{config, lib, pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ", highrr, auto, 1";

      general = {
        resize_on_border = true;
      };

      decoration = {
        rounding = 6;
        active_opacity = 0.95;
        inactive_opacity = 0.88;

        blur = {
          enabled = true;
        };
      };

      input = {
        touchpad = {
          natural_scroll = true;
        };
      };

      gestures = {
        workspace_swipe = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        font_family = "JetBrainsMono NerdFont";
      };

      bind = let
        numKeys = builtins.concatLists (builtins.genList (i: let
            ws = i + 1;
          in [
            "ALT, code:1${toString i}, workspace, ${toString ws}"
            "ALT SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ])
          9);

        directionals = builtins.concatMap (delta: [
          "ALT, ${delta}, movefocus, ${builtins.substring 0 1 delta}"
          "ALT SHIFT, ${delta}, movewindow, ${builtins.substring 0 1 delta}"
        ]) ["left" "right" "up" "down"];
      in
        [
          "SUPER, SUPER_L, exec, alacritty"
          "ALT, TAB, cyclenext"
          "ALT, TAB, bringactivetotop"
        ]
        ++ numKeys
        ++ directionals;
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      listener = [
        {
          timeout = 30;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 300;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
