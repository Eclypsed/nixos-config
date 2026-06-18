{
  self,
  inputs,
  ...
}:
{
  flake.modules.nixos.niri =
    { pkgs, ... }:
    {
      imports = [
        inputs.niri.nixosModules.niri
      ];

      nixpkgs.overlays = [ inputs.niri.overlays.niri ];

      programs = {
        niri = {
          enable = true;
          package = pkgs.niri-unstable;
        };
        uwsm = {
          waylandCompositors.niri = {
            prettyName = "Niri";
            binPath = "/run/current-system/sw/bin/niri-session";
          };
        };
      };

      environment.systemPackages = [ pkgs.xwayland-satellite-unstable ];

      home-manager.sharedModules = [
        self.modules.homeManager.niri
      ];
    };

  flake.modules.homeManager.niri =
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
      yazi = lib.getExe' config.programs.yazi.package "yazi";
      noctalia-shell = lib.getExe' config.programs.noctalia-shell.package "noctalia-shell";
      playerctl = lib.getExe' pkgs.playerctl "playerctl";
      wpctl = lib.getExe' pkgs.wireplumber "wpctl";
      brightnessctl = lib.getExe' pkgs.brightnessctl "brightnessctl";
    in
    {
      home.packages = [
        pkgs.nautilus
        pkgs.tilda
      ];

      xdg.portal = {
        enable = true;
        configPackages = [ pkgs.gnome-session ];
        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
          xdg-desktop-portal-gtk
        ];
      };

      programs.niri = {
        config = ''
          input {
            keyboard {
              xkb {
                layout "us"
                model ""
                rules ""
                variant ""
                options "compose:ralt"
              }
              repeat-delay 400
              repeat-rate 35
              track-layout "global"
            }
            touchpad {
              tap
              dwt
              drag true
              drag-lock
              scroll-method "two-finger"
              click-method "clickfinger"
              tap-button-map "left-right-middle"
            }
            warp-mouse-to-focus mode="center-xy-always"
            focus-follows-mouse
            mod-key "Super"
          }
          screenshot-path "${config.xdg.userDirs.extraConfig.SCREENSHOTS}/%Y%m%d-%H%M%S.png"
          prefer-no-csd
          layout {
            gaps 16
            struts {
                left 0
                right 0
                top 0
                bottom 0
            }
            focus-ring { width 4; }
            border { off; }
            default-column-width
            center-focused-column "never"
          }
          cursor {
            xcursor-theme "${config.home.pointerCursor.name}"
            xcursor-size ${toString config.home.pointerCursor.size}
            hide-when-typing
          }
          hotkey-overlay { skip-at-startup; }
          environment { "NIXOS_OZONE_WL" "1"; }
          binds {
            Alt+XF86AudioLowerVolume allow-when-locked=true hotkey-overlay-title="Lower microphone volume" { spawn "${wpctl}" "set-volume" "@DEFAULT_AUDIO_SOURCE@" "0.05-"; }
            Alt+XF86AudioMute allow-when-locked=true hotkey-overlay-title="Mute microphone" repeat=false { spawn "${wpctl}" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
            Alt+XF86AudioRaiseVolume allow-when-locked=true hotkey-overlay-title="Raise microphone volume" { spawn "${wpctl}" "set-volume" "@DEFAULT_AUDIO_SOURCE@" "0.05+"; }
            Mod+A hotkey-overlay-title="Launcher" repeat=false { spawn "${vicinae}" "toggle"; }
            Mod+BracketLeft hotkey-overlay-title="Move window left" repeat=false { consume-or-expel-window-left; }
            Mod+BracketRight hotkey-overlay-title="Move window right" repeat=false { consume-or-expel-window-right; }
            Mod+Ctrl+0 hotkey-overlay-title="Reset display scale" { spawn "output-scale" "1.0"; }
            Mod+Ctrl+Equal hotkey-overlay-title="Increase display scale" { spawn "output-scale" "+0.1"; }
            Mod+Ctrl+F hotkey-overlay-title="Fill empty column space" repeat=false { expand-column-to-available-width; }
            Mod+Ctrl+J hotkey-overlay-title="Focus workspace down" repeat=false { focus-workspace-down; }
            Mod+Ctrl+K hotkey-overlay-title="Focus workspace up" repeat=false { focus-workspace-up; }
            Mod+Ctrl+Minus hotkey-overlay-title="Decrease display scale" { spawn "output-scale" "-0.1"; }
            Mod+Ctrl+N hotkey-overlay-title="Clear notifications" repeat=false { spawn "${noctalia-shell}" "ipc" "call" "notifications" "clear"; }
            Mod+Ctrl+Shift+J hotkey-overlay-title="Move column to workspace down" repeat=false { move-column-to-workspace-down; }
            Mod+Ctrl+Shift+K hotkey-overlay-title="Move column to workspace up" repeat=false { move-column-to-workspace-up; }
            Mod+E hotkey-overlay-title="File Explorer" repeat=false { spawn "${foot}" "-e" "${yazi}"; }
            Mod+Equal hotkey-overlay-title="Increase column width" { set-column-width "+10%"; }
            Mod+Escape hotkey-overlay-title="Session menu" repeat=false { spawn "${noctalia-shell}" "ipc" "call" "sessionMenu" "toggle"; }
            Mod+F hotkey-overlay-title="Maximize Column" repeat=false { maximize-column; }
            Mod+H hotkey-overlay-title="Focus window left" repeat=false { focus-column-or-monitor-left; }
            Mod+J hotkey-overlay-title="Focus window down" repeat=false { focus-window-or-monitor-down; }
            Mod+K hotkey-overlay-title="Focus window up" repeat=false { focus-window-or-monitor-up; }
            Mod+L hotkey-overlay-title="Focus window right" repeat=false { focus-column-or-monitor-right; }
            Mod+Minus hotkey-overlay-title="Decrease column width" { set-column-width "-10%"; }
            Mod+N hotkey-overlay-title="Show notifications" repeat=false { spawn "${noctalia-shell}" "ipc" "call" "notifications" "toggleHistory"; }
            Mod+Print hotkey-overlay-title="Screenshot window" repeat=false { screenshot-window; }
            Mod+Q hotkey-overlay-title="Close window" repeat=false { close-window; }
            Mod+Shift+Equal hotkey-overlay-title="Increase window height" { set-window-height "+10%"; }
            Mod+Shift+F hotkey-overlay-title="Fullscreen" repeat=false { fullscreen-window; }
            Mod+Shift+H hotkey-overlay-title="Move column left" repeat=false { move-column-left-or-to-monitor-left; }
            Mod+Shift+J hotkey-overlay-title="Move column down" repeat=false { move-window-down; }
            Mod+Shift+K hotkey-overlay-title="Move column up" repeat=false { move-window-up; }
            Mod+Shift+L hotkey-overlay-title="Move column right" repeat=false { move-column-right-or-to-monitor-right; }
            Mod+Shift+Minus hotkey-overlay-title="Decrease window height" { set-window-height "-10%"; }
            Mod+Slash hotkey-overlay-title="Show hotkeys" repeat=false { show-hotkey-overlay; }
            Mod+T hotkey-overlay-title="Toggle tabbed column" repeat=false { toggle-column-tabbed-display; }
            Mod+Tab hotkey-overlay-title="Toggle overview" repeat=false { toggle-overview; }
            Mod+W hotkey-overlay-title="Terminal" repeat=false { spawn "${foot}"; }
            Mod+Z hotkey-overlay-title="Toggle floating" repeat=false { toggle-window-floating; }
            Print hotkey-overlay-title="Screenshot" repeat=false { screenshot show-pointer=false; }
            Shift+Print hotkey-overlay-title="Screenshot screen" repeat=false { screenshot-screen show-pointer=false; }
            XF86AudioLowerVolume allow-when-locked=true hotkey-overlay-title="Lower volume" { spawn "${wpctl}" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-"; }
            XF86AudioMute allow-when-locked=true hotkey-overlay-title="Mute playback" repeat=false { spawn "${wpctl}" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
            XF86AudioNext hotkey-overlay-title="Next track" repeat=false { spawn "${playerctl}" "next"; }
            XF86AudioPlay hotkey-overlay-title="Play / pause track" repeat=false { spawn "${playerctl}" "play-pause"; }
            XF86AudioPrev hotkey-overlay-title="Previous track" repeat=false { spawn "${playerctl}" "previous"; }
            XF86AudioRaiseVolume allow-when-locked=true hotkey-overlay-title="Raise volume" { spawn "${wpctl}" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+"; }
            XF86MonBrightnessDown allow-when-locked=true hotkey-overlay-title="Decrease brightness" { spawn "${brightnessctl}" "set" "5%-"; }
            XF86MonBrightnessUp allow-when-locked=true hotkey-overlay-title="Increase brightness" { spawn "${brightnessctl}" "set" "5%+"; }
          }
          spawn-at-startup "noctalia-shell"
          blur {
            passes 2
            offset 7.0
            noise 0.01
            saturation 0.8
          }
          window-rule {
            geometry-corner-radius 10.000000 10.000000 10.000000 10.000000
            clip-to-geometry true
          }
          window-rule {
            match app-id="foot"
            match app-id="Alacritty"
            default-column-width { proportion 0.400000; }
            opacity 0.850000
            background-effect {
              blur true
            }
          }
          layer-rule {
            match namespace="^noctalia-overview*"
            place-within-backdrop true
          }
          gestures { hot-corners { off; }; }
          xwayland-satellite { path "${lib.getExe pkgs.xwayland-satellite-unstable}"; }
        '';
        # settings = {
        #   input = {
        #     keyboard = {
        #       xkb = {
        #         layout = "us";
        #         options = "compose:ralt";
        #       };
        #     };
        #     touchpad = {
        #       enable = true;
        #       click-method = "clickfinger";
        #       drag = true;
        #       drag-lock = true;
        #       dwt = true;
        #       natural-scroll = false;
        #       scroll-method = "two-finger";
        #       tap = true;
        #       tap-button-map = "left-right-middle"; # Mouse button click to register when tapping with 1, 2, or 3 fingers
        #     };
        #     warp-mouse-to-focus = {
        #       enable = true;
        #       mode = "center-xy-always";
        #     };
        #     focus-follows-mouse = {
        #       enable = true;
        #     };
        #     mod-key = "Super";
        #   };
        #   binds = {
        #     # General
        #     "Mod+Slash" = {
        #       action.show-hotkey-overlay = { };
        #       repeat = false;
        #       hotkey-overlay.title = "Show hotkeys";
        #     };
        #     "Mod+Q" = {
        #       action.close-window = { };
        #       repeat = false;
        #       hotkey-overlay.title = "Close window";
        #     };
        #     "Mod+W" = {
        #       action.spawn = foot;
        #       repeat = false;
        #       hotkey-overlay.title = "Terminal";
        #     };
        #     "Mod+A" = {
        #       action.spawn = [
        #         vicinae
        #         "toggle"
        #       ];
        #       repeat = false;
        #       hotkey-overlay.title = "Launcher";
        #     };
        #     "Mod+E" = {
        #       action.spawn = [
        #         foot
        #         "-e"
        #         yazi
        #       ];
        #       repeat = false;
        #       hotkey-overlay.title = "File Explorer";
        #     };
        #     "Mod+Escape" = {
        #       action.spawn = [
        #         noctalia-shell
        #         "ipc"
        #         "call"
        #         "sessionMenu"
        #         "toggle"
        #       ];
        #       repeat = false;
        #       hotkey-overlay.title = "Session menu";
        #     };

        #     # Notifications
        #     "Mod+N" = {
        #       action.spawn = [
        #         noctalia-shell
        #         "ipc"
        #         "call"
        #         "notifications"
        #         "toggleHistory"
        #       ];
        #       repeat = false;
        #       hotkey-overlay.title = "Show notifications";
        #     };
        #     "Mod+Ctrl+N" = {
        #       action.spawn = [
        #         noctalia-shell
        #         "ipc"
        #         "call"
        #         "notifications"
        #         "clear"
        #       ];
        #       repeat = false;
        #       hotkey-overlay.title = "Clear notifications";
        #     };

        #     # Media keys
        #     "XF86AudioPrev" = {
        #       action.spawn = [
        #         playerctl
        #         "previous"
        #       ];
        #       repeat = false;
        #       hotkey-overlay.title = "Previous track";
        #     };
        #     "XF86AudioPlay" = {
        #       action.spawn = [
        #         playerctl
        #         "play-pause"
        #       ];
        #       repeat = false;
        #       hotkey-overlay.title = "Play / pause track";
        #     };
        #     "XF86AudioNext" = {
        #       action.spawn = [
        #         playerctl
        #         "next"
        #       ];
        #       repeat = false;
        #       hotkey-overlay.title = "Next track";
        #     };
        #     "XF86AudioRaiseVolume" = {
        #       action.spawn = [
        #         wpctl
        #         "set-volume"
        #         "@DEFAULT_AUDIO_SINK@"
        #         "0.05+"
        #       ];
        #       repeat = true;
        #       allow-when-locked = true;
        #       hotkey-overlay.title = "Raise volume";
        #     };
        #     "XF86AudioLowerVolume" = {
        #       action.spawn = [
        #         wpctl
        #         "set-volume"
        #         "@DEFAULT_AUDIO_SINK@"
        #         "0.05-"
        #       ];
        #       repeat = true;
        #       allow-when-locked = true;
        #       hotkey-overlay.title = "Lower volume";
        #     };
        #     "XF86AudioMute" = {
        #       action.spawn = [
        #         wpctl
        #         "set-mute"
        #         "@DEFAULT_AUDIO_SINK@"
        #         "toggle"
        #       ];
        #       repeat = false;
        #       allow-when-locked = true;
        #       hotkey-overlay.title = "Mute playback";
        #     };
        #     "Alt+XF86AudioRaiseVolume" = {
        #       action.spawn = [
        #         wpctl
        #         "set-volume"
        #         "@DEFAULT_AUDIO_SOURCE@"
        #         "0.05+"
        #       ];
        #       repeat = true;
        #       allow-when-locked = true;
        #       hotkey-overlay.title = "Raise microphone volume";
        #     };
        #     "Alt+XF86AudioLowerVolume" = {
        #       action.spawn = [
        #         wpctl
        #         "set-volume"
        #         "@DEFAULT_AUDIO_SOURCE@"
        #         "0.05-"
        #       ];
        #       repeat = true;
        #       allow-when-locked = true;
        #       hotkey-overlay.title = "Lower microphone volume";
        #     };
        #     "Alt+XF86AudioMute" = {
        #       action.spawn = [
        #         wpctl
        #         "set-mute"
        #         "@DEFAULT_AUDIO_SOURCE@"
        #         "toggle"
        #       ];
        #       repeat = false;
        #       allow-when-locked = true;
        #       hotkey-overlay.title = "Mute microphone";
        #     };

        #     # Brightness
        #     "XF86MonBrightnessUp" = {
        #       action.spawn = [
        #         brightnessctl
        #         "set"
        #         "5%+"
        #       ];
        #       repeat = true;
        #       allow-when-locked = true;
        #       hotkey-overlay.title = "Increase brightness";
        #     };
        #     "XF86MonBrightnessDown" = {
        #       action.spawn = [
        #         brightnessctl
        #         "set"
        #         "5%-"
        #       ];
        #       repeat = true;
        #       allow-when-locked = true;
        #       hotkey-overlay.title = "Decrease brightness";
        #     };

        #     # Screen capture
        #     "Print" = {
        #       action.screenshot = {
        #         show-pointer = false;
        #       };
        #       repeat = false;
        #       hotkey-overlay.title = "Screenshot";
        #     };
        #     "Mod+Print" = {
        #       action.screenshot-window = {
        #         # show-pointer = false;
        #       };
        #       repeat = false;
        #       hotkey-overlay.title = "Screenshot window";
        #     };
        #     "Shift+Print" = {
        #       action.screenshot-screen = {
        #         show-pointer = false;
        #       };
        #       repeat = false;
        #       hotkey-overlay.title = "Screenshot screen";
        #     };

        #     # Display scaling
        #     "Mod+Ctrl+Equal" = {
        #       action.spawn = [
        #         "output-scale"
        #         "+0.1"
        #       ];
        #       repeat = true;
        #       hotkey-overlay.title = "Increase display scale";
        #     };
        #     "Mod+Ctrl+Minus" = {
        #       action.spawn = [
        #         "output-scale"
        #         "-0.1"
        #       ];
        #       repeat = true;
        #       hotkey-overlay.title = "Decrease display scale";
        #     };
        #     "Mod+Ctrl+0" = {
        #       action.spawn = [
        #         "output-scale"
        #         "1.0"
        #       ];
        #       repeat = true;
        #       hotkey-overlay.title = "Reset display scale";
        #     };

        #     # Window and column size
        #     "Mod+F" window.maximize-column = { };
        #       repeat = false;
        #       hotkeywindow Column";
        #     };
        #     "Mod+Shift+F" = {
        #       action.fullscreen-window = { };
        #       repeat = false;
        #       hotkey-overlay.title = "Fullscreen";
        #     };
        #     "Mod+Ctrl+F" = {
        #       action.expand-column-to-available-width = { };
        #       repeat = false;
        #       hotkey-overlay.title = "Fill empty column space";
        #     };
        #     "Mod+Equal" = {
        #       action.set-column-width = "+10%";
        #       repeat = true;
        #       hotkey-overlay.title = "Increase column width";
        #     };
        #     "Mod+Minwindow action.set-column-width = "-10%";
        #       repeat = true;
        #       hotkeywindow column width";
        #     };
        #     "Mod+Shiwindow{
        #       action.set-window-height = "+10%";
        #       repeatwindowy-overlay.title = "Increase window height";
        #     };
        #     "Mod+Shift+Minus" = {
        #       action.set-window-height = "-10%";
        #       repeat = true;
        #       hotkey-overlay.title = "Decrease window height";
        #     };
        #     "Mod+Z" = {
        #       action.toggle-window-floating = { };
        #       repeat = false;
        #       hotkey-overlay.title = "Toggle floating";
        #     };
        #     "Mod+T" = {
        #       action.toggle-column-tabbed-display = { };
        #       repeat = false;
        #       hotkey-overlay.title = "Toggle tabbed column";
        #     };

        #     # Window and column movement
        #     "Mod+K" = {
        #       action.focus-window-or-monitor-up = { };
        #       repeat = false;
        #       hotkey-overlay.title = "Focus window up";
        #     };
        #     "Mod+J" = {
        #       action.focus-window-or-monitor-down = { };
        #       repeat = false;
        #       hotkey-overlay.title = "Focus window down";
        #     };
        #     "Mod+H" = {
        #       action.focus-column-or-monitor-left = { };
        #       repeat = false;
        #       hotkey-overlay.title = "Focus window left";
        #     };
        #     "Mod+L" = {
        #       action.focus-column-or-monitor-right = { };
        #       repeat = false;
        #       hotkey-overlay.title = "Focus window right";
        #     };
        #     "Mod+BracketLeft" = {
        #       action.consume-or-expel-window-left = { };
        #       repeat = false;
        #       hotkey-overlay.title = "Move window left";
        #     };
        #     "Mod+Brawindow action.consume-or-expel-window-right = { };
        #       repeat = false;
        #       hotkeywindow window right";
        #     };
        #     "Mod+Shiwindow{
        #       action.move-column-to-monitor-up = { };
        #       repeatwindowy-overlay.title = "Move column up";
        #     };
        #     "Mod+Shiwindow{
        #       action.move-column-to-monitor-down = { };
        #       repeatwindowy-overlay.title = "Move column down";
        #     };
        #     "Mod+Shiwindow{
        #       action.move-column-left-or-to-monitor-left = { };
        #       repeatwindowy-overlay.title = "Move column left";
        #     };
        #     "Mod+Shift+L" = {
        #       action.move-column-right-or-to-monitor-right = { };
        #       repeat = false;
        #       hotkey-overlay.title = "Move column right";
        #     };

        #     # Workspaces
        #     "Mod+Ctrl+K" = {
        #       action.focus-workspace-up = { };
        #       repeat = false;
        #       hotkey-overlay.title = "Focus workspace up";
        #     };
        #     "Mod+Ctrl+J" = {
        #       action.focus-workspace-down = { };
        #       repeat = false;
        #       hotkey-overlay.title = "Focus workspace down";
        #     };
        #     "Mod+Ctrl+Shift+K" = {
        #       action.move-column-to-workspace-up = { };
        #       repeat = false;
        #       hotkey-overlay.title = "Move column to workspace up";
        #     };
        #     "Mod+Ctrl+Shift+J" = {
        #       action.move-column-to-workspace-down = { };
        #       repeat = false;
        #       hotkey-overlay.title = "Move column to workspace down";
        #     };

        #     # Overview
        #     "Mod+Tab" = {
        #       action.toggle-overview = { };
        #       repeat = false;
        #       hotkey-overlay.title = "Toggle overview";
        #     };
        #   };
        #   window-rules = [
        #     {
        #       geometry-corner-radius = {
        #         bottom-left = 10.0;
        #         bottom-right = 10.0;
        #         top-left = 10.0;
        #         top-right = 10.0;
        #       };
        #       clip-to-geometry = true;
        #     }
        #     # Unfortunately windows like firefox extensions set their titles after spawning preventing
        #     # the window rules from being applied. There is a script to fix this but it is pretty hacky.
        #     # {
        #     #   matches = [
        #     #     {
        #     #       title = "^Extension:.*";
        #     #       app-id = "firefox";
        #     #     }
        #     #   ];
        #     #   open-floating = true;
        #     # }
        #     {
        #       matches = [
        #         { app-id = "foot"; }
        #         { app-id = "Alacritty"; }
        #       ];
        #       opacity = 0.90;
        #       default-column-width.proportion = 0.4;
        #     }
        #   ];
        #   layer-rules = [
        #     {
        #       # Use noctalia wallpaper as overview backdrop
        #       matches = [ { namespace = "^noctalia-overview*"; } ];
        #       place-within-backdrop = true;
        #     }
        #   ];
        #   prefer-no-csd = true;
        #   screenshot-path = "${config.xdg.userDirs.extraConfig.SCREENSHOTS}/%Y%m%d-%H%M%S.png";
        #   hotkey-overlay = {
        #     skip-at-startup = true;
        #   };
        #   spawn-at-startup = [
        #     { argv = [ "noctalia-shell" ]; }
        #   ];
        #   cursor = {
        #     size = config.home.pointerCursor.size;
        #     theme = config.home.pointerCursor.name;
        #     hide-when-typing = true;
        #   };
        #   gestures = {
        #     hot-corners.enable = false;
        #   };
        #   xwayland-satellite = {
        #     enable = true;
        #     path = lib.getExe pkgs.xwayland-satellite-unstable;
        #   };
        #   environment = {
        #     "NIXOS_OZONE_WL" = "1";
        #   };
        #   debug = {
        #     # Allows notification actions and window activation from Noctalia.
        #     honor-xdg-activation-with-invalid-serial = { };
        #   };
        #   # Support for external 'includes' sounds like it is in the works.
        #   # Will just have to wait until then for noctalia color scheme integration.
        # };
      };
    };
}
