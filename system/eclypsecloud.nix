{ config, inputs, ... }:
let
  automount_opts = [
    "x-systemd.automount"
    "noauto"
    "x-systemd.idle-timeout=60"
    "x-systemd.device-timeout=5s"
    "x-systemd.mount-timeout=5s"
    "user"
    "users"
  ];
in
{
  imports = [
    inputs.agenix.nixosModules.default
  ];

  age.secrets.eclypsecloud-credentials.file = ../secrets/eclypsecloud-credentials.age;

  # Enable EclypseCloud share.
  fileSystems."/mnt/EclypseCloud" = {
    device = "//100.115.135.37/EclypseCloud";
    fsType = "cifs";
    options = [
      "credentials=${config.age.secrets.eclypsecloud-credentials.path}"
      "uid=1000"
      "gid=100"
    ] ++ automount_opts;
  };
}
