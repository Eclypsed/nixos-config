{
  flake.modules.homeManager.swappy =
    {
      config,
      ...
    }:
    {
      programs.swappy = {
        enable = true;
        # Configuration options: https://github.com/jtheoof/swappy?tab=readme-ov-file#config
        settings = {
          Default = {
            save_dir = config.xdg.userDirs.extraConfig.SCREENSHOTS;
            save_filename_format = "%Y%m%d-%H%M%S.png";
            show_panel = false;
            auto_save = false;
            early_exit = true;
          };
        };
      };
    };
}
