{
  inputs,
  ...
}:
{
  flake.modules.nixos.profiles-wsl =
    { pkgs, ... }:
    {
      # Edit this configuration file to define what should be installed on
      # your system. Help is available in the configuration.nix(5) man page, on
      # https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

      # NixOS-WSL specific options are documented on the NixOS-WSL repository:
      # https://github.com/nix-community/NixOS-WSL

      imports = [
        # include NixOS-WSL modules
        inputs.nixos-wsl.nixosModules.default
      ];

      boot.kernelModules = [ "vhci-hcd" ]; # Needed for usbip auto-attach

      wsl = {
        enable = true;
        defaultUser = "eclypse";
        startMenuLaunchers = true;
        useWindowsDriver = true;
        usbip = {
          enable = true;
        };
      };

      services = {
        pcscd = {
          enable = true;
          plugins = with pkgs; [
            ccid
          ];
        };
        udev.extraRules = ''
          SUBSYSTEM=="usb", MODE="0666"
          KERNEL=="hidraw*", SUBSYSTEM=="hidraw", TAG+="uaccess", MODE="0666"
        '';
      };

      security.polkit = {
        enable = true;
        extraConfig = ''
          polkit.addRule(function(action, subject) {
            if ((action.id == "org.debian.pcsc-lite.access_pcsc" || action.id == "org.debian.pcsc-lite.access_card") && subject.isInGroup("wheel")) {
              return polkit.Result.YES;
            }
          });
        '';
      };
    };
}
