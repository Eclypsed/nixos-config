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
      devShells.default = pkgs.mkShell {
        packages = [ config.agenix-rekey.package ];
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

      # Host public age key. Should be provisioned on dev machine, sending the private key to the target host before deployment.
      options.hostPubkey = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "The public key of the host. Will be null until generated on first rebuild";
      };

      # Again, need to have config here for some reason
      config.age =
        let
          agekey_identity_path = "/etc/host.age";
        in
        {
          # Need to explicitly set identity paths because OpenSSH daemon is disabled
          # but the host keys are still generated via services.openssh.generateHostKeys = true
          identityPaths = map (key: key.path) config.services.openssh.hostKeys ++ [ agekey_identity_path ];
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
