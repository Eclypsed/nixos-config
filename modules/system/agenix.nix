{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    inputs.agenix.nixosModules.default
    inputs.agenix-rekey.nixosModules.default
  ];

  environment.systemPackages = [
    # agenix-rekey's CLI tool replaces standard agenix's
    inputs.agenix-rekey.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  age = {
    # Need to explicitly set identity paths because OpenSSH daemon is disabled
    # but the host keys are still generated via services.openssh.generateHostKeys = true
    identityPaths = map (key: key.path) config.services.openssh.hostKeys;
    rekey = {
      masterIdentities = [ "${inputs.self}/secrets/age-yubikey-identity-d9ed335b.pub" ];
      storageMode = "local";
      localStorageDir = ../../. + "/secrets/rekeyed/${config.host.name}";
    }
    # We only set the hostPubkey if one is supplied. For new hosts the pub key will not
    # exist until it is generated after the first rebuild. Runtime decryption will fail
    # but then the ssh host key will be generated in /etc/ssh and can be supplied
    // lib.optionalAttrs (config.host.pubKey != null) {
      hostPubkey = config.host.pubKey;
    };
    secrets = {
      tailscale-auth.rekeyFile = ../../secrets/tailscale-auth.age;
      eclypsecloud-eclypse.rekeyFile = ../../secrets/eclypsecloud-eclypse.age;
      eclypse-password.rekeyFile = ../../secrets/eclypse-password.age;
    };
  };
}
