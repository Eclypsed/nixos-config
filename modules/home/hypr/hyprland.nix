{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    waybar
    hyprpolkitagent
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;

    settings = {
      monitor = [
        "eDP-1, 2256x1504@60, 0x0, 1"
      ];

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

      exec-once = [
        "systemctl --user enable --now waybar.service"
        "systemctl --user enable --now hyprpolkitagent.service"
        "wpaperd -d"
        "systemctl enable --user app-com.mitchellh.ghostty.service"
      ];

      env = [
        "NIXOS_OZONE_WL, 1"
      ];
    };
  };
}
