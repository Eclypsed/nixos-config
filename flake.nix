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
    nix-jmu-cs345.url = "github:Eclypsed/nix-jmu-cs345/main";
    nix-jmu-cs345-dev.url = "path:/home/eclypse/programming-projects/nix-jmu-cs345";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs system; };
          modules = [
            # System module
            ./modules/nixos/system.nix

            # Host configuration
            ./hosts/framework13/configuration.nix

            # User modules
            ./users/eclypse

            # Home manager
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }

          ];
        };
      };
    };
}
