{
  nixpkgs.overlays = [
    (import ./heybrochecklog.nix)
    (import ./pywalfox-native.nix)
    (import ./monique.nix)
  ];
}
