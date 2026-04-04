{
  inputs,
  ...
}:
{
  imports = [
    inputs.agenix-rekey.flakeModule
  ];

  perSystem =
    { config, pkgs, ... }:
    {
      devShells.nix = pkgs.mkShell {
        nativeBuildInputs = [ config.agenix-rekey.package ];
      };

      agenix-rekey.nixosConfigurations = inputs.self.nixosConfigurations;
    };

  flake.modules.nixos.agenix =
    {
      config,
      lib,
      ...
    }:
    {
      imports = [
        inputs.agenix.nixosModules.default
        inputs.agenix-rekey.nixosModules.default
      ];

      services.openssh.generateHostKeys = true;

      age = {
        # Need to explicitly set identity paths because OpenSSH daemon is disabled
        # but the host keys are still generated via services.openssh.generateHostKeys = true
        identityPaths = map (key: key.path) config.services.openssh.hostKeys;
        rekey = {
          masterIdentities = [ (inputs.secrets + "/age-yubikey-identity-d9ed335b.pub") ];
          storageMode = "local";
          localStorageDir = inputs.secrets + "/rekeyed/${config.networking.hostName}";
        }
        # We only set the hostPubkey if one is supplied. For new hosts the pub key will not
        # exist until it is generated after the first rebuild. Runtime decryption will fail
        # but then the ssh host key will be generated in /etc/ssh and can be supplied
        // lib.optionalAttrs (config.hostPubkey != null) {
          hostPubkey = config.hostPubkey;
        };
      };
    };
}
