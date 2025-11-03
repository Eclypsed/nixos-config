{
  inputs,
  pkgs,
  ...
}:
let
  sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default;
in
{
  imports = [
    inputs.mango.nixosModules.mango
  ];

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    mango.enable = true;
    # uwsm = {
    #   enable = true;
    #   waylandCompositors = {
    #     mango = {
    #       prettyName = "Mango";
    #       comment = "Lightweight compositor based on dwl";
    #       binPath = "/run/current-system/sw/bin/mango";
    #     };
    #   };
    # };
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
