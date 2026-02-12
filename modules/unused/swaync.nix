{
  ...
}:
{
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      cssPriority = "user"; # "application"

      control-center-width = 380;
      control-center-height = 860;
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 10;

      notification-window-width = 400;
      notification-icon-size = 48;
      notification-body-image-height = 100;
      notification-body-image-width = 200;

      timeout = 4;
      timeout-low = 2;
      timeout-critical = 6;

      fit-to-screen = false;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = false;
      script-fail-notify = true;
      scripts = {
        example-script = {
          exec = "echo 'Do something...'";
          urgency = "Normal";
        };
      };
      notification-visibility = {
        example-name = {
          state = "muted";
          urgency = "low";
          app-name = "Spotify";
        };
      };
      widgets = [
        "label"
        "buttons-grid"
        "mpris"
        "dnd"
        "title"
        "notifications"
      ];
      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = " 󰎟 ";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        label = {
          max-lines = 1;
          text = " ";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
        };
        volume = {
          label = "󰕾";
          show-per-app = true;
        };
        buttons-grid = {
          actions = [
            {
              label = "";
              command = "pamixer -t";
            }
            {
              label = "";
              command = "pamixer --default-source -t";
            }
            {
              label = "";
              command = "nmtui";
            }
            # {
            #   label = "󰂯";
            #   command = "blueman-manager";
            # }
            # {
            #   label = "󰏘";
            #   command = "nwg-look";
            # }
          ];
        };
      };
    };
  };
}
