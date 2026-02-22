{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  programs = {
    niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
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

  environment.systemPackages = [ pkgs.xwayland-satellite-unstable ];

  nixpkgs.overlays = [
    inputs.niri.overlays.niri
  ];

  services.displayManager = {
    gdm = {
      enable = true;
      wayland = true;
    };
  };
}
