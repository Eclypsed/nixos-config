{
  pkgs,
  ...
}:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "catppuccin"
    ];
    extraPackages = [ pkgs.nixd ];

    userSettings = {
      theme = "Catppuccin Mocha";
      features = {
        edit_prediction_provider = "copilot";
      };
    };
  };
}
