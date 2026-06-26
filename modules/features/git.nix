{
  flake.modules.homeManager.git =
    {
      pkgs,
      config,
      ...
    }:
    let
      name = "Eclypsed";
      email = "Ec1ypsed@proton.me";
      signingKey = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIB2h6y1Al2OVotYIpwPZMjiBLAncAI2pAPgES2+gVbJqAAAABHNzaDo= ssh:";
    in
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
