{
  pkgs,
  ...
}:
{
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
    kitty = {
      enable = true;
      enableGitIntegration = true;
      font = {
        name = "FiraCode Nerd Font";
        package = pkgs.nerd-fonts.fira-code;
      };
      shellIntegration = {
        enableZshIntegration = true;
      };
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };
  };
}
