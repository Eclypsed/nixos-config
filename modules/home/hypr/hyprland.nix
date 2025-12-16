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

      animations = {
        # Stolen from https://github.com/Vobledoble/nixparency-dots/
        enabled = true;
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

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
          popups = true;
        };

        shadow.enabled = false;
      };

      misc = {
        vfr = true;
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
