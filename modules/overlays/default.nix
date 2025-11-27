{
  ...
}:
{
  nixpkgs.overlays = [
    (import ./heybrochecklog.nix)

    (self: super: {
      # battery-status = prev.writeShellApplication {
      #   name = "battery-status";
      #   text = builtins.readFile ./battery-status.sh;
      # };
      check-capslock = super.writeShellApplication {
        name = "check-capslock";
        text = builtins.readFile ./check-capslock.sh;
      };
    })
  ];
}
