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
      theme = "Noctalia Dark";
      features = {
        edit_prediction_provider = "copilot";
      };
    };
  };
}
