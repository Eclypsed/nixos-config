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
            SCREENSHOTS = "${config.xdg.userDirs.pictures}/Screenshots";
          };
        };
      };
    };
}
