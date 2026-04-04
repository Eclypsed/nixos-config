{
  self,
  inputs,
  ...
}:
let
  username = "eclypse";
in
{
  flake.modules.nixos.${username} =
    { config, pkgs, ... }:
    {
      users.mutableUsers = false;
      users.users.${username} = {
        isNormalUser = true;
        uid = 1000;
        description = "Eclypse";
        extraGroups = [
          "networkmanager"
          "wheel"
          "scanner"
          "lp"
          "dialout"
        ];
        hashedPasswordFile = config.age.secrets.eclypse-password.path;
        shell = pkgs.zsh;
      };

      age.secrets.eclypse-password.rekeyFile = "${inputs.secrets}/eclypse-password.age";

      home-manager.users.${username} = {
        imports = [ self.modules.homeManager.${username} ];
      };
    };

  flake.modules.homeManager.${username} =
    { pkgs, ... }:
    {
      imports = with self.modules.homeManager; [
        inputs.nix-jmu-cs345.homeManagerModules.bernstdh
        direnv
        fastfetch
        firefox
        foot
        fzf
        git
        helix
        kanshi
        niri
        noctalia
        ssh
        starship
        stylix
        swappy
        vesktop
        vicinae
        xdg
        yazi
        zed
        zellij
        zoxide
        zsh
      ];

      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        stateVersion = "25.05";
      };

      programs.home-manager.enable = true;
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
    };
}
