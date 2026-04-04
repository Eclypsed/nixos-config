{
  flake.modules.homeManager.xdg =
    {
      config,
      ...
    }:
    {
      xdg = {
        enable = true;
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
