{
  description = "System Configuration Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mango.url = "github:DreamMaoMao/mango?rev=1271832e947d3d4af27b36f687edd2f2e535f051";

    hyprland.url = "github:hyprwm/Hyprland";

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprdynamicmonitors.url = "github:fiffeek/hyprdynamicmonitors";

    elephant = {
      url = "github:abenz1267/elephant";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      agenix-rekey,
      ...
    }@inputs:
    {
      nixosConfigurations.vanta = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          host = "vanta";
          wallpaper = "twilight-village.png";
          # Host public SSH key (e.g. /etc/ssh/ssh_host_ed25519_key.pub).
          hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaDVBJdMDFL8r9NQCbaLe+DPHGhGzRv2N7+7m1/U8DP";
        };
        modules = [
          ./modules/system
          ./hosts/vanta
        ];
      };

      agenix-rekey = agenix-rekey.configure {
        userFlake = self;
        nixosConfigurations = self.nixosConfigurations;
      };
    };
}
