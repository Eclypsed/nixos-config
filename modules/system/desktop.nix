{
  inputs,
  ...
}:
{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  programs = {
    niri.enable = true;
    uwsm = {
      enable = true;
      waylandCompositors = {
        niri = {
          prettyName = "Niri";
          binPath = "/run/current-system/sw/bin/niri-session";
        };
      };
    };
  };

  services.displayManager = {
    gdm = {
      enable = true;
      wayland = true;
    };
  };
}
