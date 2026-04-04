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
            font = "${config.stylix.fonts.monospace.name}:size=${toString config.stylix.fonts.sizes.terminal}";
          };
          mouse = {
            hide-when-typing = "yes";
          };
        };
      };
    };
}
