{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.agenix.nixosModules.default
  ];

  environment.systemPackages = [
    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default # CLI Tool
  ];

  age.secrets = {
    tailscale-auth.file = ../../secrets/tailscale-auth.age;
    eclypsecloud-eclypse.file = ../../secrets/eclypsecloud-eclypse.age;
    eclypse-password.file = ../../secrets/eclypse-password.age;
  };
}
