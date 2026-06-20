{
  inputs,
  ...
}:
{
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
  ];

  perSystem =
    {
      config,
      system,
      pkgs,
      ...
    }:
    let
      python-extensions = python-final: python-prev: {
        pprp = python-final.callPackage "${inputs.packages}/pprp.nix" { };
      };
    in
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [
          (final: prev: {
            pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [ python-extensions ];
          })
        ];
      };
      packages = {
        heybrochecklog = pkgs.callPackage "${inputs.packages}/heybrochecklog.nix" { };
        niri-display-manager = pkgs.callPackage "${inputs.packages}/niri-display-manager.nix" { };
        pywalfox-native = pkgs.callPackage "${inputs.packages}/pywalfox-native.nix" { };
        sysand = pkgs.callPackage "${inputs.packages}/sysand.nix" { };
      };
      overlayAttrs = {
        inherit (config.packages)
          heybrochecklog
          niri-display-manager
          pywalfox-native
          sysand
          ;

        pythonPackagesExtensions = pkgs.pythonPackagesExtensions ++ [ python-extensions ];
      };
    };
}
