{
  pkgs,
  ...
}:
{
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
    fastfetch = {
      enable = true;
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
          "[╭─](fg:base02)"
          "[ 󱄅 ](bg:base02 fg:base07)"
          "[](bg:base07 fg:base02)"
          "[( $username(@$hostname) )](bg:base07 fg:base02)"
          "[](bg:red fg:base07)"
          "[ $directory ](bg:red fg:base02)"
          "[](bg:cyan fg:red)"
          "[( $git_branch $git_status )](bg:cyan fg:base02)"
          "[](fg:cyan bg:blue)"
          "[(( $golang)( $nodejs)( $rust)( $python) )](bg:blue fg:base02)"
          "[](fg:blue)"
          "$line_break"
          "[╰─](fg:base02)"
          "$character"
        ];
        username = {
          show_always = true;
          style_user = "none";
          style_root = "none";
          format = "[$user]($style)";
        };
        hostname = {
          style = "none";
          format = "[$hostname]($style)";
          ssh_only = false;
        };
        character = {
          success_symbol = "[❯](bold fg:green)";
          error_symbol = "[✘](bold fg:red)";
          vimcmd_symbol = "[❮](bold fg:green)";
          vimcmd_replace_one_symbol = "[❮](bold fg:lavender)";
          vimcmd_replace_symbol = "[❮](bold fg:lavender)";
          vimcmd_visual_symbol = "[❮](bold fg:yellow)";
        };
        directory = {
          style = "none";
          format = "[$path]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
          substitutions = {
            "Documents" = "󰈙 ";
            "Downloads" = " ";
            "Music" = " ";
            "Pictures" = " ";
          };
        };
        git_branch = {
          symbol = "";
          style = "none";
          format = "[$symbol $branch]($style)";
        };
        git_status = {
          style = "none";
          format = "[$all_status$ahead_behind]($style)";
        };
        golang = {
          symbol = "";
          style = "none";
          format = "[$symbol( $version)]($style)";
        };
        nodejs = {
          symbol = "";
          style = "none";
          format = "[$symbol( $version)]($style)";
        };
        python = {
          symbol = "";
          style = "none";
          format = "[$symbol( $version)( \\($virtualenv\\))]($style)";
        };
        rust = {
          symbol = "";
          style = "none";
          format = "[$symbol( $version)]($style)";
        };
        scan_timeout = 100;
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
        stu = "ssh stu";
        ff = "fastfetch";
      };
    };
  };
}
