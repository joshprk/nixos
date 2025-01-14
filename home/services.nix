{...}: {
  services.hypridle = {
    enable = true;
    settings = {
      listener = [
        {
          timeout = 480;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  services.udiskie = {
    enable = true;
  };
}
