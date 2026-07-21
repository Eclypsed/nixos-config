{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.vanta = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.modules.nixos.vanta ];
  };

  flake.modules.nixos.vanta =
    { pkgs, ... }:
    {
      imports = with self.modules.nixos; [
        vantaHardware
        intel
        system-base
        agenix
        bluetooth
        boot
        eclypsecloud-shares
        firmware
        fprintd
        niri
        noctalia
        pipewire
        power-management
        printing
        tailscale
        yubikey

        # Users
        eclypse
      ];

      home-manager.users.eclypse = {
        imports = with self.modules.homeManager; [
          bat
          btop
          devenv
          eza
          fastfetch
          firefox
          fonts
          foot
          fzf
          git
          helix
          shikane
          ssh
          starship
          styling
          swappy
          vesktop
          vicinae
          xdg
          yazi
          zed
          zellij
          zoxide
          zsh
        ];
        home.packages = with pkgs; [
          obsidian
          upscayl
          trayscale
          cura-appimage

          # CD Stuff
          picard
          heybrochecklog
          rsgain
          vlc

          opencode
        ];
      };

      # programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ]; # Enable this in a module that needs it

      services.openssh.generateHostKeys = true;
      hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaDVBJdMDFL8r9NQCbaLe+DPHGhGzRv2N7+7m1/U8DP";

      networking.hostName = "vanta";

      # This option defines the first version of NixOS you have installed on this particular machine,
      # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
      #
      # Most users should NEVER change this value after the initial install, for any reason,
      # even if you've upgraded your system to a new NixOS release.
      #
      # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
      # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
      # to actually do that.
      #
      # This value being lower than the current NixOS release does NOT mean your system is
      # out of date, out of support, or vulnerable.
      #
      # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
      # and migrated your data accordingly.
      #
      # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
      system.stateVersion = "25.05"; # Did you read the comment?
    };
}
