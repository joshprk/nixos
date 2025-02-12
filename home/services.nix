{...}: {
  services.hypridle = {
    enable = true;
    settings = {
      listener = [
        {
          timeout = 300;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
