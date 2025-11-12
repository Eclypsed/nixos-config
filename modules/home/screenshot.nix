{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    hyprshot
    satty
  ];

  xdg.configFile."satty/config.toml".text = ''
    [general]
    fullscreen = false
    output-filename = "${config.xdg.userDirs.extraConfig.XDG_SCREENSHOTS_DIR}/%Y-%m-%d_%H:%M:%S.png"
  '';
}
