{
  flake.modules.nixos.fprintd = {
    services.fprintd.enable = true;

    # Fixes some issue with greeters and lock screens hanging
    security.pam.services = {
      greetd.fprintAuth = false;
      su.fprintAuth = false;
    };
  };
}
