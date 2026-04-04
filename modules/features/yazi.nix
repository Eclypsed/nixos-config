{
  flake.modules.homeManager.yazi =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        dragon-drop
      ];

      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        shellWrapperName = "y";
        plugins = with pkgs.yaziPlugins; {
          inherit git full-border chmod;
        };
        initLua = ''
          require("git"):setup {
          	-- Order of status signs showing in the linemode
          	order = 1500,
          }
          require("full-border"):setup()
        '';
        keymap = {
          mgr.prepend_keymap = [
            {
              on = "<C-d>";
              run = "shell -- dragon-drop -x -i -T %s1";
              desc = "Open a prompt to drag and drop a file";
            }
            {
              on = [
                "c"
                "m"
              ];
              run = "plugin chmod";
              desc = "Chmod on selected files";
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
                id = "git";
                url = "*";
                run = "git";
              }
              {
                id = "git";
                url = "*/";
                run = "git";
              }
            ];
          };
        };
      };
    };
}
