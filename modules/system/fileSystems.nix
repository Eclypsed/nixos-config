{
  pkgs,
  config,
  ...
}:
let
  automount_opts = [
    "x-systemd.automount"
    "x-systemd.idle-timeout=60"
    "x-systemd.device-timeout=5s"
    "x-systemd.mount-timeout=5s"
    "noauto"
    "user"
    "users"
  ];
in
{
  fileSystems = {
    "/mnt/EclypseCloud" = {
      device = "//100.78.212.35/EclypseCloud";
      fsType = "cifs";
      options = [
        "credentials=${config.age.secrets.eclypsecloud-eclypse.path}"
        "uid=${toString config.users.users.eclypse.uid}"
        "rw"
      ]
      ++ automount_opts;
    };
    "/mnt/Music" = {
      device = "//100.78.212.35/music";
      fsType = "cifs";
      options = [
        "credentials=${config.age.secrets.eclypsecloud-eclypse.path}"
        "uid=${toString config.users.users.eclypse.uid}"
        "rw"
      ]
      ++ automount_opts;
    };
  };

  environment.systemPackages = with pkgs; [
    cifs-utils
    # rclone
  ];
}
