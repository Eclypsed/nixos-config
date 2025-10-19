{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [ git-ignore ];

  programs = {
    git = {
      enable = true;
      userName = "Eclypsed";
      userEmail = "Ec1ypsed@proton.me";
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };
    lazygit = {
      enable = true;
    };
  };
}
