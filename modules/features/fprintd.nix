{
  flake.modules.nixos.fprintd = {
    services.fprintd.enable = true;

    # Fixes some issue with greeters and lock screens hanging.
    # Noctalia's lock screen authenticates against the `login` PAM service and
    # drives the fingerprint reader itself over D-Bus, so pam_fprintd must be
    # stripped from that stack or the two fight for the sensor.
    security.pam.services = {
      greetd.fprintAuth = false;
      login.fprintAuth = false;
      su.fprintAuth = false;
    };
  };
}
