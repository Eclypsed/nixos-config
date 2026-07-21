{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.system-base =
    { pkgs, ... }:
    {
      imports = [
        inputs.nur.modules.nixos.default
        inputs.home-manager.nixosModules.home-manager # Might want to factor out home manager since some systems might not use it at all
      ];

      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        backupFileExtension = "backup";
      };

      environment = {
        systemPackages = with pkgs; [
          vim
          git
          disktui
        ];
        variables = {
          EDITOR = "vim";
        };
      };

      networking.networkmanager.enable = true;

      nix = {
        nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          substituters = [
            "https://cache.nixos.org"
            "https://nix-community.cachix.org"
            "https://devenv.cachix.org"
            "https://vicinae.cachix.org"
          ];
          trusted-public-keys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
            "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
          ];
        };
      };

      nixpkgs = {
        config = {
          allowUnfree = true;
        };
        overlays = [
          self.overlays.default
        ];
      };

      programs.nix-ld.enable = true;

      # Set your time zone.
      time.timeZone = "America/New_York";

      # Select internationalisation properties.
      i18n = {
        defaultLocale = "en_US.UTF-8";
        extraLocaleSettings = {
          LC_ADDRESS = "en_US.UTF-8";
          LC_IDENTIFICATION = "en_US.UTF-8";
          LC_MEASUREMENT = "en_US.UTF-8";
          LC_MONETARY = "en_US.UTF-8";
          LC_NAME = "en_US.UTF-8";
          LC_NUMERIC = "en_US.UTF-8";
          LC_PAPER = "en_US.UTF-8";
          LC_TELEPHONE = "en_US.UTF-8";
          LC_TIME = "en_US.UTF-8";
        };
      };

      users.mutableUsers = false;

      # zsh
      programs.zsh.enable = true;
      environment.pathsToLink = [ "/share/zsh" ];
    };
}
