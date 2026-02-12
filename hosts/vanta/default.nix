{
  inputs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
    ./hardware-configuration.nix
    ../../profiles/intel.nix
    ../hosts.nix
  ];

  host = {
    name = "vanta";
    pubKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaDVBJdMDFL8r9NQCbaLe+DPHGhGzRv2N7+7m1/U8DP";
  };
}
