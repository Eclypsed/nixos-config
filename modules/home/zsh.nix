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
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = true;
        format = pkgs.lib.concatStrings [
          "[░▒▓](#f38ba8)"
          "[ 󱄅 ](fg:#1e1e2e bg:#f38ba8)"
          "[](fg:#f38ba8 bg:#fab387)"
          "$directory"
          "[](fg:#fab387 bg:#f9e2af)"
          "$git_branch"
          "$git_status"
          "[](fg:#f9e2af bg:#a6e3a1)"
          "$nodejs"
          "$rust"
          "$golang"
          "$php"
          "[](fg:#a6e3a1)"
          "$line_break"
          "$character"
        ];
        directory = {
          style = "fg:#1e1e2e bg:#fab387";
          format = "[ $path ]($style)";
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
          style = "bg:#f9e2af";
          format = "[[ $symbol $branch ](fg:#1e1e2e bg:#f9e2af)]($style)";
        };
        git_status = {
          style = "bg:#f9e2af";
          format = "[[($all_status$ahead_behind )](fg:#1e1e2e bg:#f9e2af)]($style)";
        };
        nodejs = {
          symbol = "";
          style = "bg:#a6e3a1";
          format = "[[ $symbol ($version) ](fg:#1e1e2e bg:#a6e3a1)]($style)";
        };
        rust = {
          symbol = "";
          style = "bg:#a6e3a1";
          format = ''[[ $symbol ($version) ](fg:#1e1e2e bg:#a6e3a1)]($style)'';
        };
        golang = {
          symbol = "";
          style = "bg:#a6e3a1";
          format = "[[ $symbol ($version) ](fg:#1e1e2e bg#a6e3a1)]($style)";
        };
        php = {
          symbol = "";
          style = "bg:#a6e3a1";
          format = "[[ $symbol ($version) ](fg:#1e1e2e bg:#a6e3a1)]($style)";
        };
        scan_timeout = 100;
      };
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        stu = "ssh stu";
      };
    };
  };
}
