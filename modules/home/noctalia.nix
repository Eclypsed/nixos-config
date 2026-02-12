{
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true; # Replaces spawn-at-startup in niri
    settings = {
      general = {
        avatarImage = "~/.face";
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
        directory = "${config.xdg.userDirs.extraConfig.XDG_WALLPAPERS_DIR}";
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
}
