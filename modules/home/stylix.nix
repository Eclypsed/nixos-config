{
  inputs,
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
    targets = {
      # firefox = {
      #   enable = true;
      #   colorTheme.enable = true;
      #   firefoxGnomeTheme.enable = true;
      #   profileNames = [ "eclypse" ];
      # };
      # gtk = {
      #   enable = true;
      # };
      qt = {
        enable = true;
      };
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 17;
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme.override {
        tweakVariants = [ "macos" ];
      };
    };
  };

  # home.pointerCursor = {
  #   enable = true;
  #   gtk.enable = true;
  #   name = "Catppuccin-Mocha-Dark-Cursors";
  #   package = pkgs.catppuccin-cursors.mochaDark;
  #   size = 16;
  # };
}
