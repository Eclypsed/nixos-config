{
  flake.modules.homeManager.yazi =
    {
      pkgs,
      lib,
      ...
    }:
    {
      home.packages = with pkgs; [
        wl-clipboard # Don't use wl-clipboard-rs because it doesn't work properly on WSL
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
        keymap = {
          mgr.prepend_keymap = [
            {
              on = "<C-d>";
              run = "shell -- ${lib.getExe pkgs.dragon-drop} -x -i -T %h";
              desc = "Open a prompt to drag and drop a file";
            }
            {
              on = "<C-c>";
              run = "plugin chmod";
              desc = "Chmod on selected files";
            }
            {
              on = [
                "c"
                "a"
                "a"
              ];
              run = "plugin compress";
              desc = "Archive selected files";
            }
            {
              on = [
                "c"
                "a"
                "p"
              ];
              run = "plugin compress -p";
              desc = "Archive selected files (password)";
            }
            {
              on = [
                "c"
                "a"
                "h"
              ];
              run = "plugin compress -ph";
              desc = "Archive selected files (password+header)";
            }
            {
              on = [
                "c"
                "a"
                "h"
              ];
              run = "plugin compress -ph";
              desc = "Archive selected files (password+header)";
            }
            {
              on = [
                "c"
                "a"
                "l"
              ];
              run = "plugin compress -l";
              desc = "Archive selected files (compression level)";
            }
            {
              on = [
                "c"
                "a"
                "u"
              ];
              run = "plugin compress -phl";
              desc = "Archive selected files (password+header+level)";
            }
            {
              on = "<C-y>";
              run = "plugin wl-clipboard";
              desc = "Copy file to clipboard";
            }
            {
              on = "<C-r>";
              run = "plugin recycle-bin";
              desc = "Open Recycle Bin Menu";
            }
            {
              on = "<C-m>";
              run = "plugin mount";
              desc = "Open Mount Manager";
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
