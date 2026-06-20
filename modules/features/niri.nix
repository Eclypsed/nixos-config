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
          enable = true;
          waylandCompositors.niri = {
            prettyName = "Niri";
            binPath = "/run/current-system/sw/bin/niri-session";
          };
        };
        xwayland.enable = true;
      };

      environment.systemPackages = with pkgs; [
        xwayland-satellite-unstable
      ];

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
      noctalia = lib.getExe' config.programs.noctalia.package "noctalia";
      playerctl = lib.getExe' pkgs.playerctl "playerctl";
      wpctl = lib.getExe' pkgs.wireplumber "wpctl";
      brightnessctl = lib.getExe' pkgs.brightnessctl "brightnessctl";
    in
    {
      xdg.portal = {
        enable = true;
        configPackages = [ pkgs.gnome-session ];
        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
          xdg-desktop-portal-gtk
        ];
      };

      # home.packages = with pkgs; [
      #   niri-display-manager
      # ];

      # systemd.user.services.niri-display-manager-daemon = {
      #   Unit = {
      #     Description = "Niri Display Manager Hotplug Daemon";
      #     PartOf = [ "graphical-session.target" ];
      #     After = [ "graphical-session.target" ];
      #   };
      #   Service = {
      #     Type = "simple";
      #     ExecStart = "${lib.getExe pkgs.niri-display-manager} --daemon";
      #     Restart = "on-failure";
      #     RestartSec = 5;
      #   };
      #   Install = {
      #     WantedBy = [ "graphical-session.target" ];
      #   };
      # };

      programs.niri = {
        settings = {
          # includes = with config.lib.niri.include; [
          #   (optional "monitors.kdl")
          # ];
          input = {
            keyboard = {
              xkb = {
                layout = "us";
                options = "compose:ralt";
              };
              repeat-delay = 400;
              repeat-rate = 35;
              track-layout = "global";
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
          screenshot-path = "${config.xdg.userDirs.extraConfig.SCREENSHOTS}/%Y%m%d-%H%M%S.png";
          prefer-no-csd = true;
          layout = {
            gaps = 16;
            struts = {
              left = 0;
              right = 0;
              top = 0;
              bottom = 0;
            };
            focus-ring = {
              width = 4;
            };
            border = {
              enable = false;
            };
            default-column-width = { };
            center-focused-column = "never";
          };
          cursor = {
            size = config.home.pointerCursor.size;
            theme = config.home.pointerCursor.name;
            hide-when-typing = true;
          };
          hotkey-overlay = {
            skip-at-startup = true;
          };
          environment = {
            "NIXOS_OZONE_WL" = "1";
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
            "Mod+E" = {
              action.spawn = [
                foot
                "-e"
                yazi
              ];
              repeat = false;
              hotkey-overlay.title = "File Explorer";
            };
            "Mod+Escape" = {
              action.spawn = [
                noctalia
                "msg"
                "panel-toggle"
                "session"
              ];
              repeat = false;
              hotkey-overlay.title = "Session menu";
            };

            # Notifications
            "Mod+Ctrl+N" = {
              action.spawn = [
                noctalia
                "msg"
                "notification-clear-history"
              ];
              repeat = false;
              hotkey-overlay.title = "Clear notifications";
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
              hotkey-overlay.title = "Maximize column";
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
              action.toggle-window-floating = { };
              repeat = false;
              hotkey-overlay.title = "Toggle floating";
            };
            "Mod+T" = {
              action.toggle-column-tabbed-display = { };
              repeat = false;
              hotkey-overlay.title = "Toggle tabbed column";
            };

            # Window and column movement
            "Mod+K" = {
              action.focus-window-or-monitor-up = { };
              repeat = false;
              hotkey-overlay.title = "Focus window up";
            };
            "Mod+J" = {
              action.focus-window-or-monitor-down = { };
              repeat = false;
              hotkey-overlay.title = "Focus window down";
            };
            "Mod+H" = {
              action.focus-column-or-monitor-left = { };
              repeat = false;
              hotkey-overlay.title = "Focus window left";
            };
            "Mod+L" = {
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
            "Mod+Shift+K" = {
              action.move-column-to-monitor-up = { };
              repeat = false;
              hotkey-overlay.title = "Move column up";
            };
            "Mod+Shift+J" = {
              action.move-column-to-monitor-down = { };
              repeat = false;
              hotkey-overlay.title = "Move column down";
            };
            "Mod+Shift+H" = {
              action.move-column-left-or-to-monitor-left = { };
              repeat = false;
              hotkey-overlay.title = "Move column left";
            };
            "Mod+Shift+L" = {
              action.move-column-right-or-to-monitor-right = { };
              repeat = false;
              hotkey-overlay.title = "Move column right";
            };

            # Workspaces
            "Mod+Ctrl+K" = {
              action.focus-workspace-up = { };
              repeat = false;
              hotkey-overlay.title = "Focus workspace up";
            };
            "Mod+Ctrl+J" = {
              action.focus-workspace-down = { };
              repeat = false;
              hotkey-overlay.title = "Focus workspace down";
            };
            "Mod+Ctrl+Shift+K" = {
              action.move-column-to-workspace-up = { };
              repeat = false;
              hotkey-overlay.title = "Move column to workspace up";
            };
            "Mod+Ctrl+Shift+J" = {
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
          spawn-at-startup = [
            { argv = [ "noctalia" ]; }
          ];
          blur = {
            enable = true;
            passes = 2;
            offset = 7.0;
            noise = 0.01;
            saturation = 0.8;
          };
          window-rules = [
            {
              geometry-corner-radius = {
                bottom-left = 10.0;
                bottom-right = 10.0;
                top-left = 10.0;
                top-right = 10.0;
              };
              clip-to-geometry = true;
            }
            # Unfortunately windows like firefox extensions set their titles after spawning preventing
            # the window rules from being applied. There is a script to fix this but it is pretty hacky.
            # {
            #   matches = [
            #     {
            #       title = "^Extension:.*";
            #       app-id = "firefox";
            #     }
            #   ];
            #   open-floating = true;
            # }
            {
              matches = [ { app-id = "foot"; } ];
              opacity = 0.85;
              default-column-width.proportion = 0.4;
              background-effect.blur = true;
            }
            {
              matches = [ { app-id = "dev.noctalia.Noctalia.Settings"; } ];
              open-floating = true;
              default-column-width = {
                fixed = 1080;
              };
              default-window-height = {
                fixed = 920;
              };
            }
          ];
          layer-rules = [
            {
              # Use noctalia wallpaper as overview backdrop
              matches = [ { namespace = "^noctalia-backdrop"; } ];
              place-within-backdrop = true;
            }
          ];
          gestures = {
            hot-corners.enable = false;
          };
          xwayland-satellite = {
            enable = true;
            path = lib.getExe pkgs.xwayland-satellite-unstable;
          };
          debug = {
            # Allows notification actions and window activation from Noctalia.
            honor-xdg-activation-with-invalid-serial = { };
          };
          # # Support for external 'includes' sounds like it is in the works.
          # Will just have to wait until then for noctalia color scheme integration.
        };
      };
    };
}
