{
  config,
  ...
}:
{
  home.file.".face".source = ../../assets/profile-picture.jpg;

  home.file."${config.xdg.userDirs.extraConfig.XDG_WALLPAPERS_DIR}" = {
    source = ../../assets/wallpapers;
    recursive = true;
  };
}
