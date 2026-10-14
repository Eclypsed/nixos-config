{
  self,
  ...
}:
{
  flake.modules.nixos.gaming = {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    programs.steam.enable = true;

    systemd.settings.Manager.DefaultLimitNOFILE = 524288;
    security.pam.loginLimits = [
      {
        domain = "@users";
        type = "hard";
        item = "nofile";
        value = "524288";
      }
    ];

    nixpkgs.overlays = [
      (_: prev: {
        # openldap fails to build, this fixes it
        openldap = prev.openldap.overrideAttrs {
          doCheck = !prev.stdenv.hostPlatform.isi686;
        };
      })
    ];

    home-manager.sharedModules = [
      self.modules.homeManager.gaming
    ];
  };

  flake.modules.homeManager.gaming =
    { pkgs, osConfig, ... }:
    {
      programs.lutris = {
        enable = true;

        # winePackages = with pkgs; [ wineWow64Packages.stagingFull ];

        protonPackages = with pkgs; [ proton-ge-bin ];

        steamPackage = osConfig.programs.steam.package;

        extraPackages = with pkgs; [
          winetricks
          file
          cabextract
          p7zip
          innoextract
          umu-launcher
          mangohud
          gamemode
          gamescope
        ];
      };
    };
}
