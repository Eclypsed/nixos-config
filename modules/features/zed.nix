{
  flake.modules.homeManager.zed =
    {
      pkgs,
      ...
    }:
    {
      programs.zed-editor = {
        enable = true;
        extensions = [
          "nix"
        ];
        extraPackages = [ pkgs.nixd ];

        mutableUserDebug = false;
        mutableUserKeymaps = false;
        mutableUserSettings = false;
        mutableUserTasks = false;

        userSettings = {
          helix_mode = true;
        };
      };
    };
}
