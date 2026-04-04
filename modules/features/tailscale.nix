{
  inputs,
  ...
}:
{
  flake.modules.nixos.tailscale =
    { config, lib, ... }:
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

      age.secrets.tailscale-auth.rekeyFile = "${inputs.secrets}/tailscale-auth.age";

      # Taildrop
      systemd.user.services.taildrop = {
        description = "Taildrop File Receiver Service";
        wantedBy = [ "default.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${lib.getExe config.services.tailscale.package} file get --verbose --loop %h/Downloads/";
        };
      };
    };
}
