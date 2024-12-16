{config, ...}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    extraUpFlags = ["--accept-routes"];
    authKeyFile = config.age.secrets.tailscale.path;
  };
}
