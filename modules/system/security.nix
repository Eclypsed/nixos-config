{
  ...
}:
{
  programs = {
    yubikey-manager.enable = true;
    yubikey-touch-detector.enable = true;
  };

  services = {
    yubikey-agent.enable = true;
  };

  security = {
    rtkit.enable = true;
  };
}
