{
  config,
  wallpaper,
  ...
}:
{
  programs.hyprlock = {
    enable = true;
    settings = with config.lib.stylix.colors; {
      general = {
        hide_cursor = true;
      };
      background = [
        {
          path = "${config.xdg.userDirs.extraConfig.XDG_WALLPAPERS_DIR}/${wallpaper}";
          blur_size = 4;
          blur_passes = 3;
        }
      ];
      input-field = [
        rec {
          size = "250, 50";
          outline_thickness = 3;
          dots_size = 0.25;
          dots_spacing = 0.4;
          outer_color = "rgba(${base0F}55)";
          capslock_color = outer_color;
          numlock_color = outer_color;
          bothlock_color = outer_color;
          inner_color = "rgba(${base0F}11)";
          font_color = "rgba(${base0F}ff)";
          fade_on_empty = true;
          placeholder_text = "<i>Password...</i>";
          position = "0, -60";
          halign = "center";
          valign = "center";
        }
      ];
      label = [
        # Hours
        {
          text = "cmd[update:1000] echo \"<b><big> $(date +\"%H\") </big></b>\"";
          color = "rgb(${base0F})";
          font_size = 112;
          font_family = "GeistMono Nerd Font";
          position = "0, 350";
          halign = "center";
          valign = "center";
        }

        # Minutes
        {
          text = "cmd[update:1000] echo \"<b><big> $(date +\"%M\") </big></b>\"";
          color = "rgb(${base0F})";
          font_size = 112;
          font_family = "GeistMono Nerd Font";
          position = "0, 220";
          halign = "center";
          valign = "center";
        }

        # Day of the Week
        {
          text = "cmd[update:18000000] echo \"<b><big> \"$(date +'%A')\" </big></b>\"";
          color = "rgb(${base0F})";
          font_size = 22;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 115";
          halign = "center";
          valign = "center";
        }

        # Date
        {
          text = "cmd[update:18000000] echo \"<b> \"$(date +'%d %b')\" </b>\"";
          color = "rgb(${base0F})";
          font_size = 18;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 85";
          halign = "center";
          valign = "center";
        }

        # Temperature
        {
          text = "cmd[update:18000000] echo \"<b>Feels like<big> $(curl -s 'wttr.in?format=%t' | tr -d '+') </big></b>\"";
          color = "rgb(${base0F})";
          font_size = 18;
          font_family = "GeistMono Nerd Font";
          position = "0, 40";
          halign = "center";
          valign = "bottom";
        }

        # Caps Lock Warning
        {
          text = "cmd[update:250] check-capslock";
          color = "rgb(${base0F})";
          font_size = 13;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, -120";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
