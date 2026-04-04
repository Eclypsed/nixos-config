{
  flake.modules.nixos.printing =
    { pkgs, ... }:
    {
      services = {
        # Enable CUPS to print documents.
        printing = {
          enable = true;
          drivers = with pkgs; [
            gutenprint
            cnijfilter2
          ];
        };

        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
      };

      hardware.sane.enable = true;
    };
}
