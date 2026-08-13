{
  flake.modules.homeManager.devenv =
    { lib, pkgs, ... }:
    {
      home.packages = with pkgs; [
        devenv
      ];

      programs.zsh.initContent = ''
        eval "$(${lib.getExe pkgs.devenv} hook zsh)"
      '';
    };
}
