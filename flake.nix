{
  description = "System Configuration Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:/NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim/nixos-24.11";
    agenix.url = "github:ryantm/agenix";
    # hyprland.url = "github:hyprwm/Hyprland";
    nix-jmu-cs345.url = "github:Eclypsed/nix-jmu-cs345/main";
    # nix-jmu-cs345-dev.url = "path:/home/eclypse/programming-projects/nix-jmu-cs345";
  };

  outputs =
    {
      nixpkgs,
      agenix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      # Define host
      host = "framework13";
      hostModule = ./hosts/${host}/configuration.nix;

      # Define users
      usernames = [ "eclypse" ];
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs system usernames; };
          modules = [
            # System module
            ./system

            # Host configuration
            hostModule

            # agenix - secrets management
            agenix.nixosModules.default
          ];
        };
      };
    };
}
