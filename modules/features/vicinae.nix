{
  flake.modules.homeManager.vicinae =
    {
      config,
      pkgs,
      ...
    }:
    {
      # Not using Vicinae's flake because the server fucking seg faults immediately
      programs.vicinae = {
        enable = true;
        systemd = {
          enable = true;
          autoStart = true;
        };
        # For configuration option documentation, see: https://github.com/vicinaehq/vicinae/blob/f6222f1e82fe2077ad42f10a6d6837dc61c67fd0/vicinae/assets/config.jsonc
        settings = {
          escape_key_behavior = "close_window";
          close_on_focus_loss = true;
          pop_to_root_on_close = true;
          favicon_service = "twenty";
          telemetry = {
            system_info = false;
          };
          font = {
            normal = {
              size = 12;
              family = builtins.head config.fonts.fontconfig.defaultFonts.monospace;
            };
          };
          theme = {
            dark = {
              name = "catppuccin-mocha";
              icon_theme = "auto";
            };
          };
        };
        extensions = [
          (config.lib.vicinae.mkExtension {
            name = "nix";
            src =
              pkgs.fetchFromGitHub {
                owner = "vicinaehq";
                repo = "extensions";
                rev = "5d1d31a698d5ac0b25b7391fcce3d920cd9c552e";
                sha256 = "sha256-u9QmD1FnLf+64o60L4ldx81m88eeK5/EgNYTEAt9qIo=";
              }
              + "/extensions/nix";
          })
        ];
      };
    };
}
