{
  config,
  ...
}:
let
  wallpapers = config.xdg.userDirs.extraConfig.XDG_WALLPAPERS_DIR;
in
{
  home.file."${wallpapers}" = {
    source = ../../wallpapers;
    recursive = true;
  };

  services.wpaperd = {
    enable = true;
    settings = {
      default = {
        mode = "center";
      };
      any = {
        path = "${wallpapers}/lanterns_of_twilight.png";
      };
    };
  };
}
