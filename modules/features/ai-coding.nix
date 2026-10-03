{
  flake.modules.homeManager.ai-coding = {
    programs = {
      claude-code = {
        enable = true;
        settings = {
          theme = "dark";
        };
      };
      opencode = {
        enable = true;
        tui.theme = "catppuccin-macchiato";
      };
    };
  };
}
