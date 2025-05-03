{
  pkgs,
  inputs,
  system,
  ...
}:
{
  programs = {
    firefox.enable = true;
    hyprland = {
      enable = true;
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      withUWSM = true;
      xwayland.enable = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  # Packages installed in the system profile. To search, run:
  # $ nix search package-name
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    fprintd
    cifs-utils
    fwupd
    wl-clipboard
    nixd
    nixfmt-rfc-style
    git-credential-oauth
    usbutils
    openssl
    nssTools
    kitty

    # LibreOffice
    libreoffice-qt
    hunspell
    hunspellDicts.en_US

    # Wine
    wineWowPackages.stable
    wineWowPackages.waylandFull
    winetricks

    inputs.agenix.packages.${system}.default
  ];
}
