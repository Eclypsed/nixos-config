{
  inputs,
  ...
}:
{
  flake.modules.homeManager.noctalia =
    {
      config,
      ...
    }:
    {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia-shell = {
        enable = true;
        settings = {
          general = {
            avatarImage = "~/.face";
            autoStartAuth = true;
            allowPasswordWithFprintd = true;
          };
          location.name = "Washington DC";
          bar = {
            widgets = {
              right = [
                {
                  id = "plugin:tailscale";
                }
                {
                  id = "Tray";
                }
                {
                  id = "NotificationHistory";
                }
                {
                  id = "Battery";
                }
                {
                  id = "Volume";
                }
                {
                  id = "Brightness";
                }
                {
                  id = "ControlCenter";
                }
              ];
            };
          };
          templates = {
            activeTemplates = [
              {
                enabled = true;
                id = "alacritty";
              }
              {
                enabled = true;
                id = "discord";
              }
              {
                enabled = true;
                id = "foot";
              }
              {
                enabled = true;
                id = "gtk";
              }
              {
                enabled = true;
                id = "helix";
              }
              {
                enabled = true;
                id = "niri";
              }
              {
                enabled = true;
                id = "pywalfox";
              }
              {
                enabled = true;
                id = "qt";
              }
              {
                enabled = true;
                id = "vicinae";
              }
              {
                enabled = true;
                id = "yazi";
              }
              {
                enabled = true;
                id = "zed";
              }
            ];
            enableUserTheming = true;
          };
          wallpaper = {
            enabled = true;
            overviewEnabled = true;
            directory = "${config.xdg.userDirs.extraConfig.WALLPAPERS}";
          };
          colorSchemes.predefinedScheme = "Catppuccin";
        };
        plugins = {
          sources = [
            {
              enabled = true;
              name = "Noctalia Plugins";
              url = "https://github.com/noctalia-dev/noctalia-plugins";
            }
          ];
          states = {
            tailscale = {
              enabled = true;
              sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
            };
            activate-linux = {
              enabled = true;
              sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
            };
          };
          version = 1;
        };
        pluginSettings = {
          tailscale = {
            refreshInterval = 5000;
            compactMode = true;
            showIpAddress = false;
            showPeerCount = false;
            hideDisconnected = false;
            terminalCommand = "foot";
            pingCount = 5;
            defaultPeerAction = "copy-ip";
          };
        };
      };
    };
}
