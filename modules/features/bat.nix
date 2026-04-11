{
  flake.modules.homeManager.bat =
    { pkgs, ... }:
    {
      programs.bat = {
        enable = true;
        extraPackages = with pkgs.bat-extras; [
          batgrep
          batman
          batpipe
          batwatch
          batdiff
          prettybat
        ];
        config = {
          theme = "Catppuccin Mocha";
        };
      };
    };
}
