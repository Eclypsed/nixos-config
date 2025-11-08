{
  inputs,
  pkgs,
  ...
}:
let
  sddm-theme = inputs.silentSDDM.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  imports = [
    inputs.mango.nixosModules.mango
  ];

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    mango.enable = true;
  };

  environment.systemPackages = [
    sddm-theme
    sddm-theme.test
  ];

  services.displayManager = {
    defaultSession = "mango";
    sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      theme = sddm-theme.pname;
      extraPackages = sddm-theme.propagatedBuildInputs;
      settings = {
        General = {
          GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
          InputMethod = "qtvirtualkeyboard";
        };
      };
    };
  };

  # Enable the KDE Plasma Desktop Environment.
  # displayManager.sddm.enable = true;
  # desktopManager.plasma5.enable = true;

  # Enable the System75 Cosmic Desktop Environment
  # displayManager.cosmic-greeter.enable = true;
  # desktopManager.cosmic = {
  #   enable = true;
  #   xwayland.enable = true;
  # };
}
