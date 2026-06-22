{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.aether = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.modules.nixos.aether ];
  };

  flake.modules.nixos.aether =
    {
      pkgs,
      lib,
      ...
    }:
    {
      imports = with self.modules.nixos; [
        profiles-wsl
        agenix
        fonts
        network
        nix
        yubikey
        zsh

        # Users
        home-manager
        eclypse
      ];

      wsl.usbip.autoAttach = [ "2-1" ];

      home-manager.users.eclypse = {
        imports = with self.modules.homeManager; [
          # inputs.private-modules.homeModules.work
          bat
          btop
          direnv
          eza
          fastfetch
          fonts
          fzf
          git
          helix
          ssh
          starship
          styling
          xdg
          yazi
          zellij
          zoxide
          zsh
        ];
        home.packages = with pkgs; [
          devenv
          opencode
        ];
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

      hostPubkey = "age1cpm5d20hyxppslel6xa3nmzhk4307w5r4wuyzvf7jka9c0zr4daqzqpe39";

      networking.hostName = "aether";

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

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It's perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.11"; # Did you read the comment?
    };
}
