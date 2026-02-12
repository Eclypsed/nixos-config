{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nix-jmu-cs345.homeManagerModules.bernstdh
  ];

  programs.nix-jmu-cs345.enable = true;

  home.packages = with pkgs; [
    zoom-us
    devenv
    htop
    obsidian

    # CD Stuff
    picard
    heybrochecklog
    rsgain

    playerctl
    brightnessctl
  ];
}
