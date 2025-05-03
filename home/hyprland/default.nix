{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Status bar
    waybar
    font-awesome

    dunst
    libnotify
    swww
    rofi-wayland

    mpvpaper
  ];

  home.file = {
    "Pictures/Wallpapers" = {
      source = ../../wallpapers;
      recursive = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      bind = [
        "$modifier, Q, killactive"
        "$mod, T, exec, kitty"
        "$mod, S, exec, rofi -show drun -show-icons"
      ];

      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      debug = {
        disable_logs = false;
      };

      exec-once = [
        "swww init & waybar & dunst"
      ];

      env = [
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
      ];
    };
  };
}
