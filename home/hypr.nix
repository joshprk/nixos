{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = ''
        mpvpaper -p -o "loop no-audio --vd-lavc-skipframe=bidir --container-fps-override=30" DP-2 ~/.config/wallpaper.mp4
      '';

      monitor = ", highrr, auto, 1, bitdepth, 10";

      general = {
        resize_on_border = true;
      };

      decoration = {
        rounding = 6;
        active_opacity = 0.9;
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
        "SUPER, SUPER_L, exec, ghostty"
        "ALT, TAB, cyclenext"
        "ALT, TAB, bringactivetotop"
        "ALT, T, togglefloating"
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
}
