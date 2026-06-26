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
    { config, ... }:
    {
      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        stateVersion = "25.05";

        file = {
          "${config.xdg.userDirs.extraConfig.WALLPAPERS}" = {
            source = "${inputs.assets}/wallpapers";
            recursive = true;
          };
          ".face".source = "${inputs.assets}/profile-picture.jpg";
        };
      };

      programs.home-manager.enable = true;
    };
}
