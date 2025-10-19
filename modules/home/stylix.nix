{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    autoEnable = false;
    targets = {
      kde.enable = true;
      lazygit.enable = true;
      vscode = {
        enable = true;
        profileNames = [ "default" ];
      };
    };
  };
}
