{
  inputs,
  ...
}:
{
  flake.modules.nixos.wsl = {
    # Edit this configuration file to define what should be installed on
    # your system. Help is available in the configuration.nix(5) man page, on
    # https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

    # NixOS-WSL specific options are documented on the NixOS-WSL repository:
    # https://github.com/nix-community/NixOS-WSL

    imports = [
      # include NixOS-WSL modules
      inputs.nixos-wsl.nixosModules.default
    ];

    wsl = {
      enable = true;
      defaultUser = "eclypse";
      startMenuLaunchers = true;
      useWindowsDriver = true;
    };

    # Use Window's ssh-sk-helper to pass through yubikey
    environment.variables.SSH_SK_HELPER = "/mnt/c/Windows/System32/OpenSSH/ssh-sk-helper.exe";
  };
}
