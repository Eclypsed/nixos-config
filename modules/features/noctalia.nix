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
          theme = {
            mode = "dark";
            source = "builtin";
            builtin = "Catppuccin";
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

              start = [ "workspaces" ];
              center = [ "clock" ];
              end = [
                "tray"
                "notifications"
                "battery"
                "volume"
                "brightness"
                "control-center"
              ];
            };
          };
          wallpaper = {
            enabled = true;
            directory = "${config.xdg.userDirs.extraConfig.WALLPAPERS}";
          };
          backdrop = {
            enabled = true;
            blur_intensity = 0.5;
            tint_intensity = 0.3;
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
