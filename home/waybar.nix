{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;

    systemd = {
      enable = true;
      target = "graphical-session.target";
    };

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = ["hyprland/workspaces"];
        modules-center = [];
        modules-right = ["tray" "battery" "clock"];

        tray = {
          spacing = 4;
        };

        battery = {
          interval = 60;
          states = {
            warning = 30;
            critical = 20;
          };

          format = "{icon}";
          format-icons = ["" "" "" "" ""];
          tooltip-format = "{capacity}%";
        };

        clock = {
          format = " {:%I:%M %p} ";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };
      };
    };

    style = ''
      * {
        opacity: 0.9;
      }
    '';
  };
}         
