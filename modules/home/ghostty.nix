{
  ...
}:
{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      term = "xterm-256color";
    };
    systemd.enable = true;
  };
}
