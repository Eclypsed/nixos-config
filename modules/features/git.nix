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

      xdg.configFile."git/allowed_signers".text = ''
        ${email} namespaces="git" ${signingKey}
      '';

      programs = {
        git = {
          enable = true;
          settings = {
            user = { inherit name email; };
            init = {
              defaultBranch = "main";
            };
            gpg.ssh.allowedSignersFile = "${config.xdg.configHome}/git/allowed_signers";
          };
          signing = {
            format = "ssh";
            key = "${config.home.homeDirectory}/.ssh/id_ed25519_sk_rk.pub";
            signByDefault = true;
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
