{
  config,
  pkgs,
  ...
}:
{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        general = {
          import = [ "${config.xdg.configHome}/alacritty/themes/noctalia.toml" ];
        };
        font = {
          normal = {
            family = "${config.stylix.fonts.monospace.name}";
            style = "Regular";
          };
          size = config.stylix.fonts.sizes.terminal;
        };
      };
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
    fastfetch = {
      enable = true;
    };
    foot = {
      enable = true;
      server.enable = false;
      settings = {
        main = {
          term = "xterm-256color";
          include = "${config.xdg.configHome}/foot/themes/noctalia";
          dpi-aware = "no";
          font = "${config.stylix.fonts.monospace.name}:size=${toString config.stylix.fonts.sizes.terminal}";
        };
        mouse = {
          hide-when-typing = "yes";
        };
      };
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = true;
        format = pkgs.lib.concatStrings [
          "[ ╭─[\\[](1)$username([@](bold 2)$hostname)[\\]:](1) $directory( $git_branch)](5)"
          "$line_break"
          "[ ╰─$character](5)"
        ];
        username = {
          style_root = "white";
          format = "[$user](3)";
          disabled = false;
          show_always = true;
        };
        hostname = {
          format = "[$hostname](bold 4)";
          disabled = false;
          ssh_only = false;
        };
        character = {
          success_symbol = "[❯](bold 5)";
          error_symbol = "[✘](bold 5)";
          vimcmd_symbol = "[❮](bold 5)";
        };
        directory = {
          read_only = "";
          format = "[ $path](5)";
          read_only_style = "bold white";
          truncation_length = 5;
        };
        git_branch = {
          symbol = "";
          style = "bright-black";
          format = "[$symbol $branch]($style)";
        };
        scan_timeout = 100;
      };
    };
    zellij = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        theme = "catppuccin-mocha";
        show_startup_tips = false;
      };
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
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
      syntaxHighlighting.enable = true;
      shellAliases = {
        ff = "fastfetch";
      };
    };
  };
}
