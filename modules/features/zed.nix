{
  flake.modules.homeManager.zed =
    {
      pkgs,
      ...
    }:
    {
      programs.zed-editor = {
        enable = true;
        extensions = [
          "nix"
        ];
        extraPackages = [ pkgs.nixd ];

        userSettings = {
          features = {
            edit_prediction_provider = "copilot";
          };
        };
      };
    };
}
