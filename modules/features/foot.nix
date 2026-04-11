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
            font = "${builtins.head config.fonts.fontconfig.defaultFonts.monospace}:size=12";
            pad = "10x10";
          };
          mouse = {
            hide-when-typing = "yes";
          };
        };
      };
    };
}
