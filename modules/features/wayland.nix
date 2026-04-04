{
  flake.modules.nixos.wayland = {
    programs = {
      uwsm.enable = true;
      xwayland.enable = true;
    };
  };
}
