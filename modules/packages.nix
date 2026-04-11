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
        overlays = [
          (final: prev: {
            pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [ python-extensions ];
          })
        ];
      };
      packages = {
        # monique = pkgs.callPackage "${inputs.packages}/monique.nix" { };
        heybrochecklog = pkgs.callPackage "${inputs.packages}/heybrochecklog.nix" { };
        pywalfox-native = pkgs.callPackage "${inputs.packages}/pywalfox-native.nix" { };
      };
      overlayAttrs = {
        inherit (config.packages)
          # monique
          heybrochecklog
          pywalfox-native
          ;

        pythonPackagesExtensions = pkgs.pythonPackagesExtensions ++ [ python-extensions ];
      };
    };
}
