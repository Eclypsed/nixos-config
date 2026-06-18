{
  flake.modules.nixos.zsh = {
    programs.zsh.enable = true;

    environment.pathsToLink = [ "/share/zsh" ];
  };

  flake.modules.homeManager.zsh =
    { config, ... }:
    {
      programs.zsh = {
        enable = true;
        enableCompletion = false;
        antidote = {
          enable = true;
          plugins = [
            "Aloxaf/fzf-tab"
          ];
        };
        autosuggestion.enable = true;
        dotDir = "${config.xdg.configHome}/zsh";
        history = {
          append = true;
          findNoDups = true;
          ignoreSpace = true;
          ignoreDups = true;
          saveNoDups = true;
          share = true;
        };
        historySubstringSearch = {
          enable = true;
          searchDownKey = "^p";
          searchUpKey = "^n";
        };
        initContent = ''
          # disable sort when completing `git checkout`
          zstyle ':completion:*:git-checkout:*' sort false
          # set descriptions format to enable group support
          # NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
          zstyle ':completion:*:descriptions' format '[%d]'
          # preview directory's content when completing cd or zoxide
          zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
          zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
          # custom fzf flags
          # NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
          zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
          # switch group using `<` and `>`
          zstyle ':fzf-tab:*' switch-group '<' '>'
        '';
        sessionVariables = {
          COLORTERM = "truecolor";
          TERM = "xterm-256color";
        };
        syntaxHighlighting.enable = true;
        shellAliases = {
          ff = "fastfetch";
        };
      };
    };
}
