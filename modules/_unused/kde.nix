{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.kde = {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.plasma-login-manager.enable = true;
    };

    home-manager.sharedModules = [
      self.modules.homeManager.kde
    ];
  };

  flake.modules.homeManager.kde =
    { pkgs, ... }:
    {
      imports = [
        inputs.plasma-manager.homeModules.plasma-manager
      ];

      home.packages = with pkgs; [
        kdePackages.kpackage
        kdePackages.krohnkite
        kdePackages.dynamic-workspaces
        klassy
      ];
    };
}
