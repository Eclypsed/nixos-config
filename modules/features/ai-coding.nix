{
  inputs,
  ...
}:
{
  flake.modules.homeManager.ai-coding =
    { pkgs, config, ... }:
    let
      llm-packages = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      programs = {
        claude-code = {
          enable = true;
          package = llm-packages.claude-code;
          # Anthropic... you are not so special that you get your own dot-folder in my home dir.
          # Go in $XDG_CONFIG_HOME like every other program on the planet.
          configDir = "${config.xdg.configHome}/claude";
          settings = {
            theme = "dark";

            attribution = {
              commit = "";
              pr = "";
            };

            permissions = {
              blockReadsOutsideWorkingDirectories = true;
              disableBypassPermissionsMode = "disable";
              disableAutoMode = "disable";

              deny = [
                "Read(**/.env*)"
                "Read(**/config/secrets.*)"
                "Read(~/.ssh/**)"
                "Read(~/.aws/**)"
                "Read(~/.kube/**)"
                "Bash(sudo *)"
                "Bash(rm -rf*)"
                "Bash(ssh *)"
                "Bash(git push *)"
              ];
            };
          };
        };
        opencode = {
          enable = true;
          package = llm-packages.opencode;
          tui.theme = "catppuccin-macchiato";
        };
      };
    };
}
