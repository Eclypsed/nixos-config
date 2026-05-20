{
  inputs,
  ...
}:
{
  flake.modules.nixos.helium = {
    imports = [
      inputs.helium.nixosModules.helium
    ];
  };

  flake.modules.homeManager.helium = {
    imports = [
      inputs.helium.homeModules.helium
    ];

    programs.helium = {
      enable = true;
      defaultBrowser = false;
      extensions = [
        {
          # Bitwarden
          id = "nngceckbapebfimnlniiiahkandclblb";
          hash = "sha256-lhjupdYi1F+MlReNjN/JFGguUagSaU2onfJ1HWEwBKc=";
        }
      ];

      extraPolicies = {
        BookmarkBarEnabled = false;
        BrowserSignIn = 0;
        DeveloperToolsAvailability = 1;
        HomepageLocation = "http://100.78.212.35:30054";
        PasswordManagerEnabled = false;
      };
    };
  };
}
