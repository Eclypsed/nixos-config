{
  flake.modules.homeManager.devenv =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        devenv
      ];

      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
      };
    };
}
