{...}: {
  services.hypridle = {
    enable = true;
    settings = {
      listener = [
        {
          timeout = 300;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 480;
          on-timeout = "systemctl suspend";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  services.udiskie = {
    enable = true;
  };
}
