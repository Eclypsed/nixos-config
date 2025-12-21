{
  pkgs,
  ...
}:
{
  programs = {
    yubikey-manager.enable = true;
    yubikey-touch-detector.enable = true;
  };

  environment.systemPackages = with pkgs; [
    age-plugin-yubikey
  ];

  services = {
    yubikey-agent.enable = true;
  };

  security = {
    rtkit.enable = true;
  };
}
