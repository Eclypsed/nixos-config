{
  config,
  pkgs,
  ...
}:
{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    authKeyFile = config.age.secrets.tailscale-auth.path;

    # * Only applied if `authKeyFile` is specified
    extraUpFlags = [
      "--ssh"
      "--accept-routes=true"
    ];
    extraSetFlags = [
      "--operator=eclypse"
    ];
  };

  # Taildrop
  systemd.user.services.taildrop = {
    description = "Taildrop File Receiver Service";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.tailscale}/bin/tailscale file get --verbose --loop %h/Downloads/";
    };
  };
}
