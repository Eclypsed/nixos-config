{
  flake.modules.homeManager.vesktop = {
    programs.vesktop = {
      enable = true;
      vencord = {
        settings = {
          oUpdate = false;
          autoUpdateNotification = false;
          notifyAboutUpdates = false;
          useQuickCss = true;
          disableMinSize = true;
          enabledThemes = [ "noctalia.theme.css" ];
        };
      };
    };
  };
}
