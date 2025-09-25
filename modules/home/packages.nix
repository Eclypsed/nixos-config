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
    bitwarden-desktop

    # Libre Office
    libreoffice-qt
    hunspell
    hunspellDicts.en_US

    # KDE
    kdePackages.kate

    # CD Stuff
    picard
    heybrochecklog
    rsgain
  ];
}
