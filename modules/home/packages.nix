{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    zoom-us
    devenv
    discord
    sqlitebrowser
    drawio
    check-capslock

    # Libre Office
    libreoffice-qt
    hunspell
    hunspellDicts.en_US

    # CD Stuff
    picard
    heybrochecklog
    rsgain

    playerctl
    pamixer
    pavucontrol
    brightnessctl
    obsidian
  ];
}
