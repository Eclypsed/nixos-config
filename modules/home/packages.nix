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
    devenv
    htop
    obsidian
    upscayl
    trayscale
    nautilus

    # CD Stuff
    picard
    heybrochecklog
    rsgain

    playerctl
    brightnessctl
    monique
    opencode
  ];
}
