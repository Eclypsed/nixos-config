{
  pkgs,
  inputs,
  system,
  ...
}:
{
  imports = [
    ./eclypsecloud.nix
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
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

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.settings = {
    # Enable flakes
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # Optimize storage on every rebuild
    # auto-optimise-store = true;
  };

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  # For firmware updates.
  services.fwupd.enable = true;

  # Define default system variables
  environment.variables = {
    EDITOR = "vim";
  };

  environment.sessionVariables = {
    WINEPREFIX = "$HOME/.eac-prefix";
    WINEARCH = "win32";
  };
}
