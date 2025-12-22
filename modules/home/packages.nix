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
    wl-clipboard-rs

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
