{
  flake.modules.homeManager.yazi =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        wl-clipboard # Don't use wl-clipboard-rs because it doesn't work properly on WSL
        dragon-drop
        trash-cli
      ];

      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        shellWrapperName = "y";
        plugins = with pkgs.yaziPlugins; {
          inherit
            git
            full-border
            chmod
            compress
            wl-clipboard
            recycle-bin
            mount
            lazygit
            ;
        };
        initLua = ''
          require("git"):setup {
          	-- Order of status signs showing in the linemode
          	order = 1500,
          }
          require("full-border"):setup()
          require("recycle-bin"):setup()
        '';
        keymap =
          let
            leader = "c";
          in
          {
            mgr.prepend_keymap = [
              {
                on = [
                  leader
                  "d"
                ];
                run = "shell -- dragon-drop -x -i -T %s1";
                desc = "Open a prompt to drag and drop a file";
              }
              {
                on = [
                  leader
                  "c"
                ];
                run = "plugin chmod";
                desc = "Chmod on selected files";
              }
              {
                on = [
                  leader
                  "a"
                  "a"
                ];
                run = "plugin compress";
                desc = "Archive selected files";
              }
              {
                on = [
                  leader
                  "a"
                  "p"
                ];
                run = "plugin compress -p";
                desc = "Archive selected files (password)";
              }
              {
                on = [
                  leader
                  "a"
                  "h"
                ];
                run = "plugin compress -ph";
                desc = "Archive selected files (password+header)";
              }
              {
                on = [
                  leader
                  "a"
                  "h"
                ];
                run = "plugin compress -ph";
                desc = "Archive selected files (password+header)";
              }
              {
                on = [
                  leader
                  "a"
                  "l"
                ];
                run = "plugin compress -l";
                desc = "Archive selected files (compression level)";
              }
              {
                on = [
                  leader
                  "a"
                  "u"
                ];
                run = "plugin compress -phl";
                desc = "Archive selected files (password+header+level)";
              }
              {
                on = [
                  leader
                  "y"
                ];
                run = "plugin wl-clipboard";
                desc = "Copy file to clipboard";
              }
              {
                on = [
                  leader
                  "r"
                ];
                run = "plugin recycle-bin";
                desc = "Open Recycle Bin Menu";
              }
              {
                on = [
                  leader
                  "m"
                ];
                run = "plugin mount";
                desc = "Open Mount Manager";
              }
              {
                on = [
                  leader
                  "l"
                ];
                run = "plugin lazygit";
                desc = "Open lazygit";
              }
            ];
          };
        settings = {
          plugin = {
            # Disable all preset previewers, preloaders
            # This is recommended by yazi when working with network shares
            preloaders = [ ];
            previewers = [ ];

            prepend_fetchers = [
              {
                url = "*";
                run = "git";
                group = "git";
              }
              {
                url = "*/";
                run = "git";
                group = "git";
              }
            ];
          };
        };
      };
    };
}
