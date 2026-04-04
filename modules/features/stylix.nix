{
  inputs,
  ...
}:
{
  flake.modules.homeManager.stylix =
    {
      config,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.stylix.homeModules.stylix
      ];

      # Not really using stylix as it was intended because IMO it sets too many defaults for some
      # programs and not enought for others, meaning I wind up setting a lot myself anyway. That
      # being said it provides a nice structure for setting fonts, cursors, icons, etc.
      stylix = {
        enable = true;
        autoEnable = false;
        polarity = "dark";
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        cursor = {
          name = "catppuccin-mocha-dark-cursors";
          package = pkgs.catppuccin-cursors.mochaDark;
          size = 16;
        };
        # For some reason setting the fonts' package option doesn't work.
        # Just use home.packages instead
        fonts = {
          monospace.name = "JetBrainsMono Nerd Font";
          sansSerif.name = "Noto Sans";
          emoji.name = "Noto Color Emoji";
          sizes = {
            applications = 12;
            terminal = 12;
          };
        };
        icons = {
          enable = true;
          package = pkgs.morewaita-icon-theme;
          light = "MoreWaita";
          dark = "MoreWaita";
        };
      };

      # Fonts
      home.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
      ];

      fonts.fontconfig = {
        enable = true;
        defaultFonts = {
          sansSerif = [ "Noto Sans" ];
          monospace = [ "JetBrainsMono Nerd Font" ];
          emoji = [ "Noto Color Emoji" ];
        };
      };

      gtk = {
        enable = true;
        colorScheme = config.stylix.polarity;
        # iconTheme is set by default by stylix.icons.enable
        theme = {
          name = "adw-gtk3-${config.stylix.polarity}";
          package = pkgs.adw-gtk3;
        };
        gtk4.theme = config.gtk.theme;
      };

      qt =
        let
          qt_settings = ver: {
            Appearance = {
              color_scheme_path = "${config.xdg.configHome}/${ver}/colors/noctalia.conf";
              custom_palette = true;
              icon_theme = config.stylix.icons.${config.stylix.polarity};
              standard_dialogs = "xdgdesktopportal";
              style = "Breeze";
            };
            Fonts = {
              fixed = "\"${config.stylix.fonts.monospace.name},${toString config.stylix.fonts.sizes.applications}\"";
              general = "\"${config.stylix.fonts.sansSerif.name},${toString config.stylix.fonts.sizes.applications}\"";
            };
          };
        in
        {
          enable = true;
          platformTheme.name = "qtct";
          style.name = "breeze";
          qt5ctSettings = qt_settings "qt5ct";
          qt6ctSettings = qt_settings "qt6ct";
        };

      home.sessionVariables = {
        QS_ICON_THEME = config.stylix.icons.${config.stylix.polarity};
      };
    };
}
