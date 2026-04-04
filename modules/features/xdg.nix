{
  flake.modules.homeManager.xdg =
    {
      config,
      pkgs,
      ...
    }:
    {
      xdg = {
        enable = true;
        portal = {
          enable = true;
          configPackages = [ pkgs.gnome-session ];
          extraPortals = with pkgs; [
            xdg-desktop-portal-gnome
            xdg-desktop-portal-gtk
          ];
        };
        userDirs = {
          enable = true;
          setSessionVariables = true;
          createDirectories = true;
          extraConfig = {
            DEV = "${config.home.homeDirectory}/Dev";
            WALLPAPERS = "${config.xdg.userDirs.pictures}/Wallpapers";
            SCREENSHOTS = "${config.xdg.userDirs.pictures}/Screenshots";
          };
        };
      };

      home.file.".face".source = ../../assets/profile-picture.jpg;

      home.file."${config.xdg.userDirs.extraConfig.WALLPAPERS}" = {
        source = ../../assets/wallpapers;
        recursive = true;
      };
    };
}
