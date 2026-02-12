{
  ...
}:
{
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile = {
          name = "laptop";
          outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
              scale = 1.0;
            }
          ];
        };
      }
      {
        profile = {
          name = "docked";
          outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "LG Electronics LG TV SSCR2 *";
              mode = "3840x2160@120Hz";
              scale = 1.0;
              status = "enable";
            }
          ];
        };
      }
    ];
  };
}
