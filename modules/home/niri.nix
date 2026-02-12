{
  pkgs,
  lib,
  config,
  ...
}:
let
  # Executables
  foot = lib.getExe' config.programs.foot.package "foot";
  vicinae = lib.getExe' config.programs.vicinae.package "vicinae";
  noctalia-shell = lib.getExe' config.programs.noctalia-shell.package "noctalia-shell";
  playerctl = lib.getExe' pkgs.playerctl "playerctl";
  wpctl = lib.getExe' pkgs.wireplumber "wpctl";
  brightnessctl = lib.getExe' pkgs.brightnessctl "brightnessctl";
in
{
  programs.niri = {
    # Niri is enabled by niri.nixosModules.nir in desktop.nix
    settings = {
      input = {
        keyboard = {
          xkb = {
            layout = "us";
            options = "compose:ralt";
          };
        };
        touchpad = {
          enable = true;
          click-method = "clickfinger";
          drag = true;
          drag-lock = true;
          dwt = true;
          natural-scroll = false;
          scroll-method = "two-finger";
          tap = true;
          tap-button-map = "left-right-middle"; # Mouse button click to register when tapping with 1, 2, or 3 fingers
        };
        warp-mouse-to-focus = {
          enable = true;
          mode = "center-xy-always";
        };
        focus-follows-mouse = {
          enable = true;
        };
        mod-key = "Super";
      };
      binds = {
        # General
        "Mod+Slash" = {
          action.show-hotkey-overlay = { };
          repeat = false;
          hotkey-overlay.title = "Show hotkeys";
        };
        "Mod+Q" = {
          action.close-window = { };
          repeat = false;
          hotkey-overlay.title = "Close window";
        };
        "Mod+W" = {
          action.spawn = foot;
          repeat = false;
          hotkey-overlay.title = "Terminal";
        };
        "Mod+A" = {
          action.spawn = [
            vicinae
            "toggle"
          ];
          repeat = false;
          hotkey-overlay.title = "Launcher";
        };
        "Mod+Escape" = {
          action.spawn = [
            noctalia-shell
            "ipc"
            "call"
            "sessionMenu"
            "toggle"
          ];
          repeat = false;
          hotkey-overlay.title = "Session menu";
        };
        "Mod+N" = {
          action.spawn = [
            noctalia-shell
            "ipc"
            "call"
            "notifications"
            "toggleHistory"
          ];
          repeat = false;
          hotkey-overlay.title = "Show notifications";
        };

        # Media keys
        "XF86AudioPrev" = {
          action.spawn = [
            playerctl
            "previous"
          ];
          repeat = false;
          hotkey-overlay.title = "Previous track";
        };
        "XF86AudioPlay" = {
          action.spawn = [
            playerctl
            "play-pause"
          ];
          repeat = false;
          hotkey-overlay.title = "Play / pause track";
        };
        "XF86AudioNext" = {
          action.spawn = [
            playerctl
            "next"
          ];
          repeat = false;
          hotkey-overlay.title = "Next track";
        };
        "XF86AudioRaiseVolume" = {
          action.spawn = [
            wpctl
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.05+"
          ];
          repeat = true;
          allow-when-locked = true;
          hotkey-overlay.title = "Raise volume";
        };
        "XF86AudioLowerVolume" = {
          action.spawn = [
            wpctl
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.05-"
          ];
          repeat = true;
          allow-when-locked = true;
          hotkey-overlay.title = "Lower volume";
        };
        "XF86AudioMute" = {
          action.spawn = [
            wpctl
            "set-mute"
            "@DEFAULT_AUDIO_SINK@"
            "toggle"
          ];
          repeat = false;
          allow-when-locked = true;
          hotkey-overlay.title = "Mute playback";
        };
        "Alt+XF86AudioRaiseVolume" = {
          action.spawn = [
            wpctl
            "set-volume"
            "@DEFAULT_AUDIO_SOURCE@"
            "0.05+"
          ];
          repeat = true;
          allow-when-locked = true;
          hotkey-overlay.title = "Raise microphone volume";
        };
        "Alt+XF86AudioLowerVolume" = {
          action.spawn = [
            wpctl
            "set-volume"
            "@DEFAULT_AUDIO_SOURCE@"
            "0.05-"
          ];
          repeat = true;
          allow-when-locked = true;
          hotkey-overlay.title = "Lower microphone volume";
        };
        "Alt+XF86AudioMute" = {
          action.spawn = [
            wpctl
            "set-mute"
            "@DEFAULT_AUDIO_SOURCE@"
            "toggle"
          ];
          repeat = false;
          allow-when-locked = true;
          hotkey-overlay.title = "Mute microphone";
        };

        # Brightness
        "XF86MonBrightnessUp" = {
          action.spawn = [
            brightnessctl
            "set"
            "5%+"
          ];
          repeat = true;
          allow-when-locked = true;
          hotkey-overlay.title = "Increase brightness";
        };
        "XF86MonBrightnessDown" = {
          action.spawn = [
            brightnessctl
            "set"
            "5%-"
          ];
          repeat = true;
          allow-when-locked = true;
          hotkey-overlay.title = "Decrease brightness";
        };

        # Screen capture
        "Print" = {
          action.screenshot = {
            show-pointer = false;
          };
          repeat = false;
          hotkey-overlay.title = "Screenshot";
        };
        "Mod+Print" = {
          action.screenshot-window = {
            # show-pointer = false;
          };
          repeat = false;
          hotkey-overlay.title = "Screenshot window";
        };
        "Shift+Print" = {
          action.screenshot-screen = {
            show-pointer = false;
          };
          repeat = false;
          hotkey-overlay.title = "Screenshot screen";
        };

        # Display scaling
        "Mod+Ctrl+Equal" = {
          action.spawn = [
            "output-scale"
            "+0.1"
          ];
          repeat = true;
          hotkey-overlay.title = "Increase display scale";
        };
        "Mod+Ctrl+Minus" = {
          action.spawn = [
            "output-scale"
            "-0.1"
          ];
          repeat = true;
          hotkey-overlay.title = "Decrease display scale";
        };
        "Mod+Ctrl+0" = {
          action.spawn = [
            "output-scale"
            "1.0"
          ];
          repeat = true;
          hotkey-overlay.title = "Reset display scale";
        };

        # Window and column size
        "Mod+F" = {
          action.maximize-column = { };
          repeat = false;
          hotkey-overlay.title = "Maximize Column";
        };
        "Mod+Shift+F" = {
          action.fullscreen-window = { };
          repeat = false;
          hotkey-overlay.title = "Fullscreen";
        };
        "Mod+Ctrl+F" = {
          action.expand-column-to-available-width = { };
          repeat = false;
          hotkey-overlay.title = "Fill empty column space";
        };
        "Mod+Equal" = {
          action.set-column-width = "+10%";
          repeat = true;
          hotkey-overlay.title = "Increase column width";
        };
        "Mod+Minus" = {
          action.set-column-width = "-10%";
          repeat = true;
          hotkey-overlay.title = "Decrease column width";
        };
        "Mod+Shift+Equal" = {
          action.set-window-height = "+10%";
          repeat = true;
          hotkey-overlay.title = "Increase window height";
        };
        "Mod+Shift+Minus" = {
          action.set-window-height = "-10%";
          repeat = true;
          hotkey-overlay.title = "Decrease window height";
        };
        "Mod+Z" = {
          action.switch-focus-between-floating-and-tiling = { };
          repeat = false;
          hotkey-overlay.title = "Toggle floating";
        };

        # Window and column movement
        "Mod+Up" = {
          action.focus-window-or-monitor-up = { };
          repeat = false;
          hotkey-overlay.title = "Focus window up";
        };
        "Mod+Down" = {
          action.focus-window-or-monitor-down = { };
          repeat = false;
          hotkey-overlay.title = "Focus window down";
        };
        "Mod+Left" = {
          action.focus-column-or-monitor-left = { };
          repeat = false;
          hotkey-overlay.title = "Focus window left";
        };
        "Mod+Right" = {
          action.focus-column-or-monitor-right = { };
          repeat = false;
          hotkey-overlay.title = "Focus window right";
        };
        "Mod+BracketLeft" = {
          action.consume-or-expel-window-left = { };
          repeat = false;
          hotkey-overlay.title = "Move window left";
        };
        "Mod+BracketRight" = {
          action.consume-or-expel-window-right = { };
          repeat = false;
          hotkey-overlay.title = "Move window right";
        };
        "Mod+Shift+Up" = {
          action.move-column-to-monitor-up = { };
          repeat = false;
          hotkey-overlay.title = "Move column up";
        };
        "Mod+Shift+Down" = {
          action.move-column-to-monitor-down = { };
          repeat = false;
          hotkey-overlay.title = "Move column down";
        };
        "Mod+Shift+Left" = {
          action.move-column-left-or-to-monitor-left = { };
          repeat = false;
          hotkey-overlay.title = "Move column left";
        };
        "Mod+Shift+Right" = {
          action.move-column-right-or-to-monitor-right = { };
          repeat = false;
          hotkey-overlay.title = "Move column right";
        };

        # Workspaces
        "Mod+Ctrl+Up" = {
          action.focus-workspace-up = { };
          repeat = false;
          hotkey-overlay.title = "Focus workspace up";
        };
        "Mod+Ctrl+Down" = {
          action.focus-workspace-down = { };
          repeat = false;
          hotkey-overlay.title = "Focus workspace down";
        };
        "Mod+Ctrl+Shift+Up" = {
          action.move-column-to-workspace-up = { };
          repeat = false;
          hotkey-overlay.title = "Move column to workspace up";
        };
        "Mod+Ctrl+Shift+Down" = {
          action.move-column-to-workspace-down = { };
          repeat = false;
          hotkey-overlay.title = "Move column to workspace down";
        };

        # Overview
        "Mod+Tab" = {
          action.toggle-overview = { };
          repeat = false;
          hotkey-overlay.title = "Toggle overview";
        };
      };
      window-rules = [
        {
          geometry-corner-radius = {
            bottom-left = 5.0;
            bottom-right = 5.0;
            top-left = 5.0;
            top-right = 5.0;
          };
          clip-to-geometry = true;
        }
      ];
      layer-rules = [
        {
          # Use noctalia wallpaper as overview backdrop
          matches = [ { namespace = "^noctalia-overview*"; } ];
          place-within-backdrop = true;
        }
      ];
      prefer-no-csd = true;
      screenshot-path = "${config.xdg.userDirs.extraConfig.XDG_SCREENSHOTS_DIR}/%Y%m%d-%H%M%S.png";
      hotkey-overlay = {
        skip-at-startup = true;
      };
      # If not using systemd for noctalia, use this
      # spawn-at-startup = [
      #   { argv = [ "noctalia-shell" ]; }
      # ];
      cursor = {
        size = 16;
        theme = "catppuccin-mocha-dark-cursors";
        hide-when-typing = true;
      };
      gestures = {
        hot-corners.enable = false;
      };
      environment = {
        "NIXOS_OZONE_WL" = "1";
      };
      debug = {
        # Allows notification actions and window activation from Noctalia.
        honor-xdg-activation-with-invalid-serial = { };
      };
      # Support for external 'inclues' sounds like it is in the works.
      # Will just have to wait until then for noctalia color scheme integration.
    };
  };
}
