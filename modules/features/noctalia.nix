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
        inputs.noctalia.nixosModules.default
        inputs.noctalia-greeter.nixosModules.default
      ];

      programs.noctalia = {
        enable = true;
        recommendedServices.enable = true;
      };

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

      home-manager.sharedModules = [
        self.modules.homeManager.noctalia
      ];
    };

  flake.modules.homeManager.noctalia =
    {
      config,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      home.packages = with pkgs; [
        jq # For plugins
      ];

      programs.noctalia = {
        enable = true;
        settings = {
          shell = {
            font_family = "Noto Sans";
            avatar_path = "${inputs.assets}/profile-picture.jpg";
            show_location = false;
            offline_mode = false;
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
                "davemhammer/tailscale:status"
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
              show_labels = false;
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
            behavior_order = [
              "lock"
              "screen-off"
              "suspend"
            ];
            pre_action_fade_seconds = 0; # The pre-fade can look a bit jank when fading to lock screen
            behavior = {
              lock = {
                timeout = 300;
                action = "lock";
                enabled = true;
              };
              screen-off = {
                timeout = 450;
                action = "screen_off";
                enabled = true;
              };
              suspend = {
                timeout = 600;
                action = "suspend";
                lock_before_suspend = true;
                enabled = true;
              };
            };
          };
          plugins = {
            enabled = [ "davemhammer/tailscale" ];
            auto_update = "none";
          };
        };
      };
    };
}
