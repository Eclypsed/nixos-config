{
  inputs,
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    hyprpolkitagent
    hyprpicker
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    settings = {
      source = [
        "${config.xdg.configHome}/hypr/monitors.conf"
        "${config.xdg.configHome}/hypr/noctalia/noctalia-colors.conf"
      ];

      # monitor = [
      #   "desc:BOE 0x095F,2256x1504@60.00,0x0,1"
      #   "desc:LG Electronics LG TV SSCR2 0x01010101,3840x2160@120.00,2256x0,1"
      # ];

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

      debug.disable_logs = false;

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
      };

      decoration = {
        rounding = 20;
        rounding_power = 2;

        # active_opacity = 0.95;
        # inactive_opacity = 0.85;
        # fullscreen_opacity = 1.0;

        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          vibrancy = 0.1696;
          new_optimizations = true;
          popups = true;
        };

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      input = {
        kb_layout = "us";
        kb_options = "compose:ralt";
      };

      misc = {
        vfr = true;
      };

      windowrule = {
        name = "floating-terminal-dropdown";
        "match:class" = "term_dropdown";
        float = "on";
      };

      exec-once = [
        "systemctl --user enable --now hyprpolkitagent.service"
        "noctalia-shell"
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
