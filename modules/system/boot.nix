{
  config,
  ...
}:
{
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [ virtualbox ];
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [
      "kvm.enable_virt_at_load=0" # Fixes some virtuallization issues
    ];
  };
}
