{
  config,
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
          size = config.stylix.fonts.sizes.applications;
          family = "${config.stylix.fonts.monospace.name}";
        };
      };
      theme = {
        light = {
          name = "noctalia";
          icon_theme = "${config.stylix.icons.light}";
        };
        dark = {
          name = "noctalia";
          icon_theme = "${config.stylix.icons.dark}";
        };
      };
    };
  };
}
