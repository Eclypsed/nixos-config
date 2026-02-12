{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;
    autoEnable = false;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    cursor = {
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 16;
    };
    fonts = {
      monospace = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
    };
    icons = {
      enable = true;
      package = pkgs.morewaita-icon-theme;
      light = "MoreWaita";
      dark = "MoreWaita";
    };
    targets = {
      foot = {
        enable = true;
        fonts.enable = true;
        colors.enable = false;
        inputs.enable = false;
        opacity.enable = false;
      };
    };
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    iconTheme.name = "MoreWaita";
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "breeze";
    qt5ctSettings = {
      Appearance = {
        color_scheme_path = "${config.xdg.configHome}/qt5ct/colors/noctalia.conf";
        custom_palette = true;
        icon_theme = "MoreWaita";
        standard_dialogs = "xdgdesktopportal";
        style = "Breeze";
      };
      Fonts = {
        fixed = "\"JetBrainsMono Nerd Font Mono,12\"";
        general = "\"JetBrainsMono Nerd Font Propo,12\"";
      };
    };
    qt6ctSettings = {
      Appearance = {
        color_scheme_path = "${config.xdg.configHome}/qt6ct/colors/noctalia.conf";
        custom_palette = true;
        icon_theme = "MoreWaita";
        standard_dialogs = "xdgdesktopportal";
        style = "Breeze";
      };
      Fonts = {
        fixed = "\"JetBrainsMono Nerd Font Mono,12\"";
        general = "\"JetBrainsMono Nerd Font Propo,12\"";
      };
    };
  };

  home.sessionVariables = {
    QS_ICON_THEME = "MoreWaita";
  };
}
