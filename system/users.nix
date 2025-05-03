{
  pkgs,
  inputs,
  usernames,
  ...
}:
let
  # System level user configurations
  userModules = map (username: ../users/${username}/user.nix) usernames;
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ] ++ userModules;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };

    # Set home-manager users
    users = builtins.listToAttrs (
      map (username: {
        name = username;
        value = {
          imports = [ ../users/${username}/home.nix ];
          home = {
            inherit username;
            homeDirectory = "/home/${username}";
            stateVersion = "24.11";
          };
          programs.home-manager.enable = true;
        };
      }) usernames
    );
  };
}
