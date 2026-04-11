{
  self,
  ...
}:
{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      imports = with self.modules.nixos; [
        agenix
        bluetooth
        boot
        firmware
        fonts
        network
        nix
        pipewire
        power-management
        printing
        tailscale
        wayland
        yubikey
        zsh
      ];

      programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

      environment = {
        systemPackages = with pkgs; [
          vim
          git
          disktui
        ];
        variables = {
          EDITOR = "vim";
        };
      };
    };
}
