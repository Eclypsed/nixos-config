{
  flake.modules.homeManager.assets =
    { config, lib, ... }:
    {
      options = {
        profilePicture = lib.mkOption {
          type = lib.types.path;
          default = null;
          description = "The user's profile picture, to be used as ~/.face";
        };
        wallpaperDir = lib.mkOption {
          type = lib.types.path;
          default = null;
          description = "The path to a directory containing wallpapers to being linked to XDG_WALLPAPERS_DIR";
        };
      };

      config.xdg.userDirs.extraConfig.WALLPAPERS = "${config.xdg.userDirs.pictures}/Wallpapers";

      config.home.file.".face".source = lib.mkIf (config.profilePicture != null) config.profilePicture;

      config.home.file."${config.xdg.userDirs.extraConfig.WALLPAPERS}" =
        lib.mkIf (config.wallpaperDir != null)
          {
            source = config.wallpaperDir;
            recursive = true;
          };
    };
}
