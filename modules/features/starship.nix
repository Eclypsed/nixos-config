{
  flake.modules.homeManager.starship =
    { lib, ... }:
    {
      programs.starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          add_newline = true;
          format = lib.strings.concatStrings [
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
    };
}
