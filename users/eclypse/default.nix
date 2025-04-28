{
  inputs,
  ...
}:

let
  username = "eclypse";
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = "Eclypse";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Define home-manager user
  home-manager = {
    extraSpecialArgs = { inherit inputs username; };
    users.${username} = import ./home.nix;
  };
}
