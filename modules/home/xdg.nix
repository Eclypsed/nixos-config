{
  config,
  ...
}:
{
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_DEV_DIR = "${config.home.homeDirectory}/Dev";
        XDG_WALLPAPERS_DIR = "${config.xdg.userDirs.pictures}/Wallpapers";
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };
  };
}
