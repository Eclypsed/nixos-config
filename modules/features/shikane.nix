{
  flake.modules.homeManager.shikane = {
    services.shikane = {
      enable = true;
      settings = {
        profile = [
          {
            name = "Laptop";
            output = [
              {
                search = "eDP-1";
                enable = true;
                scale = 1.0;
              }
            ];
          }
          {
            name = "Docked";
            output = [
              {
                search = "eDP-1";
                enable = false;
                scale = 1.0;
              }
              {
                search = [
                  "m=LG TV SSCR2"
                  "s=0x01010101"
                  "v=LG Electronics"
                ];
                enable = true;
                scale = 1.0;
                mode = {
                  width = 3840;
                  height = 2160;
                  refresh = 120;
                };
                position = "0,0";
              }
            ];
          }
        ];
      };
    };
  };
}
