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

      home-manager.users.eclypse = {
        imports =
          with self.modules.homeManager;
          [
            ai-coding
            bat
            btop
            devenv
            eza
            fastfetch
            fzf
            helix
            ssh
            starship
            styling
            xdg
            yazi
            zellij
            zoxide
            zsh
          ]
          ++ (with self.factory.homeManager; [
            (git {
              name = "Eclypsed";
              email = "Ec1ypsed@proton.me";
              signingKey = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIB2h6y1Al2OVotYIpwPZMjiBLAncAI2pAPgES2+gVbJqAAAABHNzaDo= ssh:";
            })
          ]);
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
