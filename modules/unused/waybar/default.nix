{
  ...
}:
{
  programs.waybar = {
    enable = false;
    systemd.enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        margin-left = 10;
        margin-right = 10;
        margin-top = 5;
        fixed-center = true;
        reload_style_on_change = false;

        "hyprland/workspaces" = import ./modules/hyprland-workspaces.nix { };
        "custom/menu" = import ./modules/menu.nix { };
        "hyprland/window" = import ./modules/hyprland-window.nix { };
        "disk" = import ./modules/disk.nix { };
        "cpu" = import ./modules/cpu.nix { };
        "memory" = import ./modules/memory.nix { };
        "temperature" = import ./modules/temperature.nix { };
        "idle_inhibitor" = import ./modules/idle-inhibitor.nix { };
        "tray" = import ./modules/tray.nix { };
        "network" = import ./modules/network.nix { };
        "wireplumber" = import ./modules/wireplumber.nix { };
        "backlight" = import ./modules/backlight.nix { };
        "mpris" = import ./modules/mpris.nix { };
        "battery" = import ./modules/battery.nix { full-at = 80; }; # Change this to come from the TLP setting
        "clock" = import ./modules/clock.nix { };
        "custom/power" = import ./modules/power.nix { };
        "custom/hyprpicker" = import ./modules/hyprpicker.nix { };
        "custom/separator#blank" = {
          format = "";
          interval = "once";
          tooltip = false;
        };

        modules-left = [
          "custom/menu"
          "custom/separator#blank"
          "clock"
          "custom/separator#blank"
          "custom/hyprpicker"
        ];

        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "tray"
          "custom/separator#blank"
          "group/motherboard"
          "custom/separator#blank"
          "wireplumber"
          "custom/separator#blank"
          "battery"
          "custom/separator#blank"
          "custom/power"
        ];

        "group/motherboard" = {
          orientation = "inherit";
          modules = [
            "cpu"
            "memory"
            "temperature"
            "disk"
          ];
        };
      }
    ];
    style = ''
      @define-color base00 #192435; /* Darkest background (night sky / deep shadows) */
      @define-color base01 #243449; /* Slightly lighter background */
      @define-color base02 #36455D; /* Selection / inactive UI */
      @define-color base03 #51637E; /* Comments / subtle foreground */

      @define-color base04 #8FA3BA; /* Dark foreground (status bars) */
      @define-color base05 #C7D2DF; /* Default foreground (text) */
      @define-color base06 #E3EAF2; /* Light foreground (highlighted text) */
      @define-color base07 #F4D9C7; /* Bright foreground (lantern light) */

      @define-color base08 #D88C7A; /* Red / Errors (warm wood & lantern glow) */
      @define-color base09 #E5AD97; /* Orange / Numbers / Constants */
      @define-color base0A #E9C48A; /* Yellow / Classes / Warnings */
      @define-color base0B #9FBFA8; /* Green / Strings */
      @define-color base0C #8FB6C8; /* Cyan / Support / Regex */
      @define-color base0D #7FA6D9; /* Blue / Functions / Keywords */
      @define-color base0E #B69BCB; /* Purple / Types / Specials */
      @define-color base0F #B0896A; /* Brown / Deprecated */

      * {
        all: unset;
        font-family: "JetBrainsMono Nerd Font Propo"; /* The Propo(rtional) variant of the ensures icons are properly spaced */
        font-feature-settings: '"zero", "tnum", "ss01", "ss02", "ss03", "cv01"';
        font-weight: 700;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
      }

      .module {
        padding: 0 6px;
      }

      .modules-left,
      .modules-center,
      .modules-right {
        background: @base00;
        padding: 6px 8px;
        border-color: @base03;
        border-width: 1.5px;
        border-style: solid;
        border-radius: 0.75rem;
      }

      #workspaces button {
        color: @base04;
        font-size: 0.9rem;
        padding: 0 7px;
      }

      #motherboard,
      #custom-menu {
        color: @base04;
      }

      #wireplumber,
      #battery,
      #custom-power,
      #custom-hyprpicker,
      #clock {
        color: @base05;
      }
    '';
  };
}
