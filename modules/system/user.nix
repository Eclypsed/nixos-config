{
  inputs,
  pkgs,
  host,
  config,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs host; };

    users.eclypse = {
      imports = [ ../home ];
      home = {
        username = "eclypse";
        homeDirectory = "/home/eclypse";
        stateVersion = "25.05";
      };
      programs.home-manager.enable = true;
    };

    backupFileExtension = "backup3";
  };

  users.mutableUsers = false;
  users.users.eclypse = {
    isNormalUser = true;
    uid = 1000;
    description = "Eclypse";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    hashedPasswordFile = config.age.secrets.eclypse-password.path;
    shell = pkgs.zsh;
  };
}
