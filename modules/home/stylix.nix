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
    fonts = {
      monospace = {
        name = "JetBrainsMono Nerd Font"; # "FiraCode Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono; # pkgs.nerd-fonts.fira-code;
      };
    };
    targets = {
      ghostty.enable = true;
      gtk.enable = true;
      firefox = {
        enable = true;
        profileNames = [ "eclypse" ];
        colorTheme.enable = true;
        firefoxGnomeTheme.enable = true;
      };
      foot.enable = true;
      lazygit.enable = true;
      starship.enable = true;
      swaync.enable = true;
      yazi.enable = true;
    };
  };

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    name = "Catppuccin-Mocha-Dark-Cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 16;
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
}
