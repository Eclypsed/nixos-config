{
  flake.modules.homeManager.styling =
    {
      config,
      pkgs,
      ...
    }:
    {
      home = {
        pointerCursor = {
          name = "catppuccin-mocha-dark-cursors";
          package = pkgs.catppuccin-cursors.mochaDark;
          size = 16;
          x11.enable = true;
          gtk.enable = true;
        };
      };

      gtk = {
        enable = true;
        colorScheme = "dark";
        iconTheme = {
          name = "MoreWaita";
          package = pkgs.morewaita-icon-theme;
        };
        theme = {
          name = "adw-gtk3-dark";
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
              icon_theme = "MoreWaita";
              standard_dialogs = "xdgdesktopportal";
              style = "Breeze";
            };
            Fonts = {
              fixed = "\"${builtins.head config.fonts.fontconfig.defaultFonts.monospace},12\"";
              general = "\"${builtins.head config.fonts.fontconfig.defaultFonts.sansSerif},12\"";
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
        QS_ICON_THEME = "MoreWaita";
      };
    };
}
