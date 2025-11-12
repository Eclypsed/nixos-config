{
  ...
}:
{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "Catppuccin Mocha";
      term = "xterm-256color";
    };
    systemd.enable = true;
  };
}
