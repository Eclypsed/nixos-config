{
  flake.modules.homeManager.ai-coding = {
    programs.claude-code = {
      enable = true;
      settings = {
        theme = "dark";
      };
    };
  };
}
