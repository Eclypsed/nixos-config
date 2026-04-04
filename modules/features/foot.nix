{
  flake.modules.homeManager.foot =
    { config, ... }:
    {
      programs.foot = {
        enable = true;
        server.enable = false;
        settings = {
          main = {
            term = "xterm-256color";
            include = "${config.xdg.configHome}/foot/themes/noctalia";
            dpi-aware = "no";
            font = "JetBrainsMono Nerd Font:size=12";
          };
          mouse = {
            hide-when-typing = "yes";
          };
        };
      };
    };
}
