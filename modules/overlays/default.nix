{
  ...
}:
{
  nixpkgs.overlays = [
    (import ./heybrochecklog.nix)
  ];
}