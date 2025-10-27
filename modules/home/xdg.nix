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
      };
    };
  };
}
