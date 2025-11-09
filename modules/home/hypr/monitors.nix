{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.hyprdynamicmonitors.homeManagerModules.default
  ];

  home.packages = [
    inputs.hyprdynamicmonitors.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  home.hyprdynamicmonitors = {
    enable = true;
    installExamples = false;
  };
}
