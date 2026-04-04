{
  description = "System Configuration Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
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

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nvf = {
    #   url = "github:notashelf/nvf";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # zen-browser = {
    #   url = "github:0xc000022070/zen-browser-flake";
    #   inputs = {
    #     # IMPORTANT: To ensure compatibility with the latest Firefox version, use nixpkgs-unstable.
    #     nixpkgs.follows = "nixpkgs";
    #     home-manager.follows = "home-manager";
    #   };
    # };

    nix-jmu-cs345.url = "github:Eclypsed/nix-jmu-cs345";

    packages = {
      flake = false;
      url = "path:./packages";
    };

    secrets = {
      flake = false;
      url = "path:./secrets";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
