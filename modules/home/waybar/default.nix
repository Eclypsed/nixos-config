{
  ...
}:
let
  hyprland-workspaces = {
    format = "{icon}";
    show-special = false;
    active-only = false;
    on-click = "activate";
    on-scroll-up = "hyprctl dispatch workspace e+1";
    on-scroll-down = "hyprctl dispatch workspace e-1";
    all-outputs = true;
    sort-by-number = true;
    persistent-workspaces = {
      "1" = [ ];
      "2" = [ ];
      "3" = [ ];
      "4" = [ ];
    };
    format-icons = {
      "1" = " ";
      "2" = " ";
      "3" = " ";
      "4" = " ";
      "5" = "";
      "6" = " ";
      "7" = "";
      "8" = " ";
      "9" = " ";
      "10" = "10";
      "focused" = "";
      "default" = "";
    };
  };

  menu = {
    format = "{}";
    exec = "echo ; echo 󱓟 app launcher";
    interval = 86400;
    tooltip = true;
    on-click = "pkill rofi || rofi -show drun -show-icons";
  };

  hyprland-window = {
    format = "󰣆 {title}";
    max-length = 40;
    separate-outputs = false;
    rewrite = {
      "^.*( — LibreWolf|LibreWolf)$" = "󰈹 LibreWolf";
      "(.*) — Mozilla Firefox" = " Firefox";
      "^.*v( .*|$)" = " Neovim";
      "^.*~$" = "󰄛 Kitty";
      "(.*) " = " Empty";
      "^.*pdf( .*|$)" = "";
      "^.*(- Mousepad)$" = " $1";
    };
  };

  arrow-right = {
    format = "󰁙";
    tooltip = false;
  };

  cpu = {
    format = "󰘚 {usage}󱉸";
  };

  memory = {
    interval = 10;
    format = "{used:0.1f}G 󰾆";
    format-alt = "{percentage}% 󰾆";
    format-alt-click = "click";
    tooltip = true;
    tooltip-format = "{used:0.1f}GB/{total:0.1f}G";
    # on-click-right = "kitty --title btop sh -c 'btop'";
  };

  temperature = {
    interval = 10;
    tooltip = true;
    hwmon-path = [
      "/sys/class/hwmon/hwmon6/temp1_input"
      "/sys/class/thermal/thermal_zone0/temp"
    ];
    critical-threshold = 82;
    format-critical = "{temperatureC}°C {icon}";
    format = "{temperatureC}°C {icon}";
    format-icons = [ "󰈸" ];
    # on-click-right = "kitty --title nvtop sh -c 'nvtop'";
  };

  idle-inhibitor = {
    format = "{icon}";
    format-icons = {
      activated = " ";
      deactivated = " ";
    };
  };

  tray = {
    icon-size = 16;
    spacing = 4;
  };

  pulseaudio = {
    format = "{icon} {volume}%";
    format-bluetooth = "{icon} 󰂰 {volume}";
    format-muted = "󰖁";
    format-icons = {
      headphone = "";
      hands-free = "";
      headset = "";
      phone = "";
      portable = "";
      car = "";
      default = [
        ""
        ""
        "󰕾"
        ""
      ];
      ignored-sinks = [ "Easy Effects Sink" ];
    };
    scroll-step = 5.0;
    # on-click-right = "pavucontrol -t 3";
    tooltip-format = "{icon} {desc} | {volume}%";
    smooth-scrolling-threshold = 1;
  };

  battery = {
    align = 0;
    rotate = 0;
    full-at = 100;
    design-capacity = false;
    states = {
      good = 95;
      warning = 30;
      critical = 15;
    };
    format = "{icon} {capacity}";
    format-charging = " {capacity}%";
    format-plugged = "󱘖 {capacity}%";
    format-alt-click = "click";
    format-full = "{icon} Full";
    format-alt = "{icon} {time}";
    format-icons = [
      "󰂎"
      "󰁺"
      "󰁻"
      "󰁼"
      "󰁽"
      "󰁾"
      "󰁿"
      "󰂀"
      "󰂁"
      "󰂂"
      "󰁹"
    ];
    format-time = "{H}h {M}min";
    tooltip = true;
    tooltip-format = "{timeTo} {power}w";
  };

  mpris = {
    interval = 10;
    format = "{player_icon} ";
    format-paused = "{status_icon}";
    on-click-middle = "playerctl play-pause";
    on-click = "playerctl previous";
    on-click-right = "playerctl next";
    scroll-step = 5.0;
    smooth-scrolling-threshold = 1;
    player-icons = {
      chromium = "";
      mpd = "";
      default = "";
      firefox = "";
      kdeconnect = "";
      mopidy = "";
      mpv = "󰐹";
      spotify = "";
      vlc = "󰕼";
    };
    status-icons = {
      paused = "󰐎";
      playing = "";
      stopped = "";
    };
    max-length = 10;
  };

  arrow-left = {
    format = "󰁒";
    tooltip = false;
  };

  notifications = {
    tooltip = false;
    format = "{icon} {text}";
    format-icons = {
      notification = "󱅫";
      none = "󰂚";
      dnd-notification = "󰂛";
      dnd-none = "󰂛";
      inhibited-notification = "󰂚";
      inhibited-none = "󰂚";
      dnd-inhibited-notification = "󰂛";
      dnd-inhibited-none = "󰂛";
    };
    return-type = "json";
    # exec-if = "which swaync-client";
    # exec = "swaync-client -swb";
    # on-click = "swaync-client -t -sw";
    # on-click-right = "swaync-client -d -sw";
    escape = true;
  };

  clock = {
    interval = 1;
    format = "{:%I:%M %p}"; # AM-PM Format
    format-alt = " {:%H:%M  %Y, %d %B, %A}";
    tooltip-format = "<tt><small>{calendar}</small></tt>";
    calendar = {
      mode = "year";
      mode-mon-col = 3;
      weeks-pos = "right";
      on-scroll = 1;
      format = {
        months = "<span color='#ffead3'><b>{}</b></span>";
        days = "<span color='#ecc6d9'><b>{}</b></span>";
        weeks = "<span color='#99ffdd'><b>W{}</b></span>";
        weekdays = "<span color='#ffcc66'><b>{}</b></span>";
        today = "<span color='#ff6699'><b><u>{}</u></b></span>";
      };
    };
  };

  power = {
    format = "⏻";
    exec = "echo ; echo 󰟡 power";
    on-click = "wlogout";
    interval = 86400;
    tooltip = true;
  };
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 34;
        width = 1200;
        margin-left = 50;
        margin-right = 50;
        margin-top = 5;
        fixed-center = true;
        reload_style_on_change = true;

        modules-left = [
          "custom/menu"
          "hyprland/window"
          "group/info"
        ];

        modules-center = [
          "hyprland/workspaces#4"
        ];

        modules-right = [
          "idle_inhibitor"
          "group/demo"
          "group/hub"
        ];

        "hyprland/workspaces#4" = hyprland-workspaces;
        "custom/menu" = menu;
        "hyprland/window" = hyprland-window;
        "custom/arrow-right" = arrow-right;
        "cpu" = cpu;
        "memory" = memory;
        "temperature" = temperature;
        "idle_inhibitor" = idle-inhibitor;
        "tray" = tray;
        "pulseaudio" = pulseaudio;
        "mpris" = mpris;
        "battery" = battery;
        "custom/arrow-left" = arrow-left;
        "custom/notifications" = notifications;
        "clock" = clock;
        "custom/power" = power;

        "group/info" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            transition-left-to-right = false;
          };
          modules = [
            "custom/arrow-right"
            "cpu"
            "memory"
            "temperature"
          ];
        };

        "group/demo" = {
          orientation = "inherit";
          modules = [
            "tray"
            "pulseaudio"
            "mpris"
            "battery"
          ];
        };

        "group/utils" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            transition-left-to-right = true;
          };
          modules = [
            "custom/arrow-left"
            "custom/notifications"
          ];
        };

        "group/hub" = {
          orientation = "inherit";
          modules = [
            "group/utils"
            "clock"
            "custom/power"
          ];
        };
      }
    ];
    style = ./style.css;
  };
}
