{
  flake.factory.nixos.cifs =
    {
      destination,
      host,
      resource,
      credentialsPath,
      uid,
      gid ? null,
    }:
    {
      lib,
      ...
    }:
    {
      fileSystems."${destination}" = {
        device = "//${host}/${resource}";
        fsType = "cifs";
        options =
          let
            automount-opts = [
              "x-systemd.automount"
              "x-systemd.idle-timeout=60"
              "x-systemd.device-timeout=5s"
              "x-systemd.mount-timeout=5s"
              "noauto"
              "nofail"
              "soft"
            ];
            mount-opts = [
              "rw"
              "iocharset=utf8"
            ];
            user = [ "uid=${toString uid}" ] ++ (lib.optionals (gid != null) [ "gid=${toString gid}" ]);
            credentials = [ "credentials=${credentialsPath}" ];
          in
          automount-opts ++ mount-opts ++ user ++ credentials;
      };
    };
}
