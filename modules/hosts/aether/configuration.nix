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
      lib,
      ...
    }:
    {
      imports = with self.modules.nixos; [
        wsl
        system-base
        agenix
        yubikey

        # Users
        eclypse
      ];

      wsl.usbip.autoAttach = [ "2-1" ];

      home-manager.users.eclypse = {
        imports = with self.modules.homeManager; [
          # inputs.private-modules.homeModules.work
          bat
          btop
          devenv
          eza
          fastfetch
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
      };

      services.openssh.generateHostKeys = true;
      hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO6iCfLqH4gSdq1jlyPdEukFmsy4BSk+JMzraUvjMqV1";

      networking.hostName = "aether";

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It's perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "26.05"; # Did you read the comment?
    };
}
