{
  flake.factory.homeManager.git =
    {
      name,
      email,
      signingKey,
    }:
    {
      pkgs,
      config,
      ...
    }:
    {
      home.packages = with pkgs; [ git-ignore ];

      programs = {
        git = {
          enable = true;
          settings = {
            user = {
              inherit name email;
              signingKey = "${config.home.homeDirectory}/.ssh/id_ed25519_sk_rk.pub";
            };
            init = {
              defaultBranch = "main";
            };
          };
          signing = {
            format = "ssh";
            signByDefault = true;
            allowedSigners = ''
              ${email} namespaces="git" ${signingKey}
            '';
          };
        };
        lazygit = {
          enable = true;
          enableZshIntegration = true;
          shellWrapperName = "lg";
        };
        gh = {
          enable = true;
          hosts = {
            "github.com" = {
              user = name;
            };
          };
          settings = {
            git_protocol = "ssh";
            prompt = "enabled";
            prefer_editor_prompt = "enabled";
            pager = "${config.programs.bat.package}";
            aliases = {
              co = "pr checkout";
            };
            color_labes = "enabled";
            accessible_colors = "disabled";
            accessible_prompter = "disabled";
            spinner = "enabled";
            telemetry = "disabled";
          };
        };
        # gh-dash?
      };
    };
}
