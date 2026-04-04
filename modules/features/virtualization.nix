{
  flake.modules.nixos.virtualization =
    { config, pkgs, ... }:
    {
      boot = {
        extraModulePackages = with config.boot.kernelPackages; [ virtualbox ];
        kernelParams = [
          "kvm.enable_virt_at_load=0" # Fixes some virtuallization issues
        ];
      };

      virtualisation = {
        podman.enable = true;
      };

      environment.systemPackages = [ pkgs.distrobox ];

      users.extraGroups.vboxusers.members = [ "eclypse" ];
    };
}
