{
  lib,
  ...
}:
{
  options.host = {
    name = lib.mkOption {
      type = lib.types.str;
      description = "Logical host name";
    };

    # Host public SSH key (e.g. /etc/ssh/ssh_host_ed25519_key.pub).
    # We only set the hostPubkey if one is supplied. For new hosts the pub key will not
    # exist until it is generated after the first rebuild.
    pubKey = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "The public key of the host. Will be null until generated on first rebuild";
    };
  };
}
