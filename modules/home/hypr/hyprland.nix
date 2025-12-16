{
  # inputs,
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    hyprpolkitagent
  ];

  # xdg.configFile."uwsm/env".source =
  #   "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

  wayland.windowManager.hyprland = {
    enable = true;
    # systemd.enable = false;
    package = null;
    portalPackage = null;

    settings = {
      source = [
        "${config.xdg.configHome}/hypr/monitors.conf"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgb(4479A4)";
        "col.inactive_border" = "rgba(4479A480)";
      };

      decoration = {
        rounding = 10;

        active_opacity = 0.95;
        inactive_opacity = 0.85;
        fullscreen_opacity = 1.0;

        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          new_optimizations = true;
        };
      };

      layerrule = [
        "blur, waybar" # Add blur to waybar
        "blurpopups, waybar" # Blur waybar popups too!
        "ignorealpha 0.2, waybar" # Make it so transparent parts are ignored
      ];

      exec-once = [
        "systemctl --user enable --now hypridle.service"
        "systemctl --user enable --now hyprpolkitagent.service"
        "systemctl --user enable app-com.mitchellh.ghostty.service"
        "wpaperd -d"
        "swaync"
        "pypr"
      ];

      env = [
        "NIXOS_OZONE_WL, 1"
        "HYPRSHOT_DIR, ${config.xdg.userDirs.extraConfig.XDG_SCREENSHOTS_DIR}"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
      ];
    };
  };
}
