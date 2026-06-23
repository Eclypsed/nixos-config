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
            SCREENSHOTS = "${config.xdg.userDirs.pictures}/Screenshots";
            WALLPAPERS = "${config.xdg.userDirs.pictures}/Wallpapers";
          };
        };
      };
    };
}
