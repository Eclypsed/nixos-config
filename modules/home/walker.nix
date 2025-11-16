{
  inputs,
  ...
}:
{
  imports = [
    inputs.walker.homeManagerModules.default
  ];

  programs.walker = {
    enable = true;
    runAsService = true;
    config = {
      close_when_open = true;
      click_to_close = true;
      providers = {
        default = [ "desktopapplications" ];
        max_results = 50;
        prefixes = [
          {
            prefix = ";";
            provider = "providerlist";
          }
          {
            prefix = ">";
            provider = "runner";
          }
          {
            prefix = "/";
            provider = "files";
          }
          {
            prefix = ".";
            provider = "symbols";
          }
          {
            prefix = "!";
            provider = "todo";
          }
          {
            prefix = "%";
            provider = "bookmarks";
          }
          {
            prefix = "=";
            provider = "calc";
          }
          {
            prefix = "@";
            provider = "websearch";
          }
          {
            prefix = ":";
            provider = "clipboard";
          }
          {
            prefix = "$";
            provider = "windows";
          }
        ];
        clipboard = {
          time_format = "%d.%m. - %H:%M"; # format for the clipboard item date
        };
      };
    };
  };
}
