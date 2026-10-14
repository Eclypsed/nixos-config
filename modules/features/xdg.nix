{
  flake.modules.homeManager.xdg =
    {
      config,
      ...
    }:
    {
      xdg = {
        enable = true;
        userDirs = {
          enable = true;
          setSessionVariables = true;
          createDirectories = true;
          extraConfig = {
            SCREENSHOTS = "${config.xdg.userDirs.pictures}/Screenshots";
            WALLPAPERS = "${config.xdg.userDirs.pictures}/Wallpapers";
          };
        };
        mimeApps =
          let
            zen = [ "zen-twilight.desktop" ];
            qimgv = [ "qimgv.desktop" ];
            helix = [ "Helix.desktop" ];
            associations = {
              "text/html" = zen;
              "application/xhtml+xml" = zen;
              "application/x-xpinstall" = zen;
              "application/pdf" = zen;
              "x-scheme-handler/http" = zen;
              "x-scheme-handler/https" = zen;
              "x-scheme-handler/about" = zen;
              "x-scheme-handler/unknown" = zen;
              "x-scheme-handler/chrome" = zen;

              "image/svg+xml" = qimgv;

              "application/json" = helix;
              "application/xml" = helix;
              "text/xml" = helix;
            };
          in
          {
            enable = true;
            defaultApplications = associations;
            # nixpkgs' wrapFirefox regenerates the zen .desktop file with a
            # fixed mime list (html, xml, xhtml+xml, xul+xml, http, https) that
            # strips pdf/json/xpinstall from upstream zen-browser-flake. The
            # qimgv and helix desktop files also don't declare the extra types
            # we map here. gio refuses to treat an app as a valid handler for a
            # mime type it doesn't advertise, so the GNOME portal shows
            # "No Apps Available" even when defaultApplications is set.
            # Re-advertising via associations.added fixes the lookup without
            # patching each .desktop file.
            associations.added = associations;
          };
      };
    };
}
