{
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
  ];

  config = {
    systems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];
  };

  # Enables the *Factory Aspect*
  options.flake.factory = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };
}
