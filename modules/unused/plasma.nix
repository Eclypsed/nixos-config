{
  inputs,
  ...
}:
{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  programs = {
    plasma = {
      enable = true;

      kscreenlocker = {
        appearance = {
          wallpaper = ../../wallpapers/lanterns_of_twilight.png;
        };
      };

      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
        wallpaper = ../../wallpapers/lanterns_of_twilight.png;
        wallpaperFillMode = "preserveAspectCrop";
      };
    };

    konsole = {
      enable = true;
      defaultProfile = "Jade";
      profiles = {
        jade = {
          name = "Jade";
          font = {
            name = "FiraCode Nerd Font";
          };
          extraConfig = {
            Appearance = {
              WordMode = true;
            };
          };
        };
      };
    };
  };
}
