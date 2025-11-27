{
  config,
  ...
}:
let
  primary-monitor = "eDP-1";

  text-color = "rgba(${config.lib.stylix.colors.base0F}FF)";
  entry-background-color = "rgba(${config.lib.stylix.colors.base0F}11)";
  entry-border-color = "rgba(${config.lib.stylix.colors.base0F}55)";
  font-family = "Rubik Light";
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        grace = 10;
      };
      background = [
        {
          path = "${config.xdg.userDirs.extraConfig.XDG_WALLPAPERS_DIR}/sunset_bay.jpg";
          blur_passes = 3;
        }
      ];
      input-field = [
        {
          monitor = primary-monitor;
          size = "250, 50";
          outline_thickness = 2;
          dots_size = 0.1;
          dots_spacing = 0.3;
          outer_color = entry-border-color;
          inner_color = entry-background-color;
          font_color = text-color;
          fade_on_empty = true;

          position = "0, 20";
          halign = "center";
          valign = "center";
        }
      ];
      label = [
        {
          # Caps Lock Warning
          monitor = primary-monitor;
          text = "cmd[update:250] check-capslock";
          color = text-color;
          font_size = 13;
          font_family = font-family;
          position = "0, -25";
          halign = "center";
          valign = "center";
        }
        {
          # Clock
          monitor = primary-monitor;
          text = "$TIME";
          color = text-color;
          font_size = 65;
          font_family = font-family;

          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          # Date
          monitor = primary-monitor;
          text = "cmd[update:5000] date +\"%A, %B %d\"";
          color = text-color;
          font_size = 17;
          font_family = font-family;

          position = "0, 240";
          halign = "center";
          valign = "center";
        }
        {
          # User
          monitor = primary-monitor;
          text = "    $USER";
          color = text-color;
          outline_thickness = 2;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          font_size = 20;
          font_family = font-family;
          position = "0, 50";
          halign = "center";
          valign = "bottom";
        }
        {
          # Status
          monitor = primary-monitor;
          text = "cmd[update:5000] hyprlock-status";
          color = text-color;
          font_size = 14;
          font_family = font-family;

          position = "30, -30";
          halign = "left";
          valign = "top";
        }
      ];
    };
  };
}
