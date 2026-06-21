{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.noctalia =
    { pkgs, ... }:
    {
      imports = [
        inputs.noctalia-greeter.nixosModules.default
      ];

      programs.noctalia-greeter = {
        enable = true;
        package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;

        # Optional configuration
        greeter-args = "";
        settings.cursor = {
          theme = "catppuccin-mocha-dark-cursors";
          size = 16;
          package = pkgs.catppuccin-cursors.mochaDark;
        };
      };

      environment.systemPackages = [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

      home-manager.sharedModules = [
        self.modules.homeManager.noctalia
      ];
    };

  flake.modules.homeManager.noctalia =
    {
      config,
      ...
    }:
    {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia = {
        enable = true;
        settings = {
          shell = {
            font_family = "Noto Sans";
            avatar_path = "${inputs.assets}/profile-picture.jpg";
            show_location = false;
          };
          theme = {
            mode = "dark";
            source = "community";
            builtin = "Catppuccin";
            community_palette = "Catppuccin Lavender";
          };
          location = {
            auto_locate = false;
            address = "Washington DC";
          };
          bar = {
            main = {
              enabled = true;
              position = "top";
              auto_hide = false;
              layer = "top";

              thickness = 38;
              background_opacity = 0.85;

              capsule = true;
              capsule_padding = 7.0;

              start = [
                "workspaces"
                "privacy"
              ];
              center = [ "clock" ];
              end = [
                "tray"
                "notifications"
                "clipboard"
                "wallpaper"
                "volume"
                "brightness"
                "battery"
                "control-center"
              ];
            };
          };
          widget = {
            clock = {
              format = "%H:%M %a, %b %d";
            };
            privacy = {
              hide_inactive = true;
            };
            workspaces = {
              display = "none";
            };
          };
          wallpaper = {
            enabled = true;
            directory = config.xdg.userDirs.extraConfig.WALLPAPERS;
          };
          backdrop = {
            enabled = true;
            blur_intensity = 0.5;
            tint_intensity = 0.3;
          };
          idle = {
            pre_action_fade_seconds = 0; # The pre-fade can look a bit jank when fading to lock screen
            behavior = {
              lock = {
                timeout = 300;
                command = "noctalia:session lock";
                enabled = true;
              };
              screen-off = {
                timeout = 450;
                command = "noctalia:dpms-off";
                resume_command = "noctalia:dpms-on";
                enabled = true;
              };
              suspend = {
                timeout = 600;
                command = "noctalia:session suspend";
                lock_before_suspend = true;
                enabled = true;
              };
            };
          };
        };
        # plugins = {
        #   sources = [
        #     {
        #       enabled = true;
        #       name = "Noctalia Plugins";
        #       url = "https://github.com/noctalia-dev/noctalia-plugins";
        #     }
        #   ];
        #   states = {
        #     tailscale = {
        #       enabled = true;
        #       sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        #     };
        #     activate-linux = {
        #       enabled = true;
        #       sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        #     };
        #   };
        #   version = 1;
        # };
        # pluginSettings = {
        #   tailscale = {
        #     refreshInterval = 5000;
        #     compactMode = true;
        #     showIpAddress = false;
        #     showPeerCount = false;
        #     hideDisconnected = false;
        #     terminalCommand = "foot";
        #     pingCount = 5;
        #     defaultPeerAction = "copy-ip";
        #   };
        # };
      };
    };
}
