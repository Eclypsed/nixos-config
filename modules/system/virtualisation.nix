{
  pkgs,
  ...
}:
{
  virtualisation = {
    # virtualbox.host = {
    #   enable = true;
    #   enableExtensionPack = true;
    # };
    podman.enable = true;
  };

  environment.systemPackages = with pkgs; [
    distrobox
  ];

  users.extraGroups.vboxusers.members = [ "eclypse" ];
}
