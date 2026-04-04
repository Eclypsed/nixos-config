{
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    exec = "hyprctl dispatch submap global";
    submap = "global";

    "$mod" = "SUPER";

    bind = [
      "$mod, Q, killactive"
      "$mod, W, exec, foot"
      "$mod, S, exec, vicinae toggle"
      "$mod, Escape, exec, noctalia-shell ipc call sessionMenu toggle"

      # Window Movement
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"
      "$mod SHIFT, left, movewindow, l"
      "$mod SHIFT, right, movewindow, r"
      "$mod SHIFT, up, movewindow, u"
      "$mod SHIFT, down, movewindow, d"
      "$mod CTRL, left, workspace, r-1"
      "$mod CTRL, right, workspace, r+1"
      "$mod CTRL SHIFT, left, movetoworkspace, r-1"
      "$mod CTRL SHIFT, right, movetoworkspace, r+1"

      # Screenshoting
      ", PRINT, exec, grim -g \"$(slurp)\" - | wl-copy"
      "SHIFT, PRINT, exec, wl-paste | swappy -f -"

      # Media Control Keys
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioMute, exec, pamixer -t"
      "ALT, XF86AudioMute, exec, pamixer --default-source -t"

      # Notification Center
      "$mod, n, exec, noctalia-shell ipc call notifications toggleHistory"

      # Scratchpads
      "$mod, TAB, exec, pypr toggle term"
    ]
    ++ (
      # workspaces
      # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
      builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      )
    );

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];

    bindel = [
      # Volume Controls
      ", XF86AudioRaiseVolume, exec, pamixer -i 5"
      ", XF86AudioLowerVolume, exec, pamixer -d 5"
      "ALT, XF86AudioRaiseVolume, exec, pamixer --default-source -i 5"
      "ALT, XF86AudioLowerVolume, exec, pamixer --default-source -d 5"

      # Brightness Controls
      ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
      ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
    ];
  };
}
