{
  flake.modules.nixos.yubikey =
    { pkgs, ... }:
    {
      programs = {
        yubikey-manager.enable = true;
        yubikey-touch-detector.enable = true;
      };

      environment.systemPackages = [
        pkgs.age-plugin-yubikey
      ];

      services.yubikey-agent.enable = true;
    };
}
