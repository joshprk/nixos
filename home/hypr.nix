{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "hyprctl setcursor catppuccin-macchiato-dark-cursors 32"
      ];

      monitor = ", highrr, auto, 1, bitdepth, 10";

      general = {
        gaps_in = 5;
        gaps_out = 10;
        resize_on_border = true;
      };

      decoration = {
        rounding = 6;
        active_opacity = 0.92;
        inactive_opacity = 0.88;
        blur.enabled = false;
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
        focus_on_activate = true;
        vrr = 2;
      };

      windowrulev2 = [
        "pin, class:Rofi"
        "stayfocused, class:Rofi"
        "noanim, class:Rofi"
      ];

      bind = let
        numKeys = builtins.concatLists (builtins.genList (i: let
          ws = i + 1;
        in [
          "ALT, code:1${toString i}, workspace, ${toString ws}"
          "ALT SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ]) 9);

        directionals = builtins.concatMap (delta: [
          "ALT, ${delta}, movefocus, ${builtins.substring 0 1 delta}"
          "ALT SHIFT, ${delta}, movewindow, ${builtins.substring 0 1 delta}"
        ]) ["left" "right" "up" "down"];
      in [
        "SUPER, SUPER_L, exec, pkill rofi || rofi -show drun"
        ", Print, exec, hyprshot -m region --clipboard-only"
        "ALT, TAB, cyclenext"
        "ALT, TAB, bringactivetotop"
        "ALT, T, togglefloating"
        "ALT, ENTER, fullscreen"
        "ALT, F4, killactive"
      ]
      ++ numKeys
      ++ directionals;

      bindm = [
        "SUPER, mouse:272, movewindow"
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 180;
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

  programs.hyprlock = {
    enable = true;
  };
}
