{
  ...
}:
{
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      sessionVariables = {
        SSH_AUTH_SOCK = "/home/eclypse/.bitwarden-ssh-agent.sock";
      };
    };
  };
}
