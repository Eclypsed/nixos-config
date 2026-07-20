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
          inputs.private-modules.homeModules.work
          bat
          btop
          direnv
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
        home.packages = with pkgs; [
          devenv
          opencode
        ];
      };

      hostPubkey = "age1cpm5d20hyxppslel6xa3nmzhk4307w5r4wuyzvf7jka9c0zr4daqzqpe39";

      networking.hostName = "aether";

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
