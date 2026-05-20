{
  flake.modules.nixos.mullvad = {
    services.mullvad-vpn = {
      enable = true;
      enableEarlyBootBlocking = true;
    };
  };
}
