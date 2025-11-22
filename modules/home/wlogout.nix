{
  config,
  pkgs,
  ...
}:
{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "loginctl lock-session";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "loginctl terminate-user $USER";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];
    # * IMPORTANT
    # * The for some reason the SVG icons will not be rendered when wlogout is called
    # * from a hyprland keybind unless librsvg is installed.
    # * See packages.nix (programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];)
    style = with config.lib.stylix.colors.withHashtag; ''
      * {
        font-family: "Rubik Light";
        background-image: none;
        box-shadow: none;
      }

      window {
        background: url("${config.xdg.userDirs.extraConfig.XDG_WALLPAPERS_DIR}/sunset_bay.jpg");
        background-size: cover;
      }

      button {
        margin: 10px;
        border-radius: 20px;
        border-color: ${base0F};
        text-decoration-color: ${base0F};
        color: ${base0F};
        background-color: alpha(${base01}, 0.5);
        border-style: solid;
        border-width: 2px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }

      button:focus, button:active, button:hover {
        background-color: alpha(${base0F}, 0.3);
        outline-style: none;
      }

      button:hover {
        background-size: 27%;
      }

      button span {
        font-size: 1.2em;
      }

      #lock {
        background-image: url("${pkgs.wlogout}/share/wlogout/assets/lock.svg");
      }

      #logout {
        background-image: url("${pkgs.wlogout}/share/wlogout/assets/logout.svg");
      }

      #suspend {
        background-image: url("${pkgs.wlogout}/share/wlogout/assets/suspend.svg");
      }

      #hibernate {
        background-image: url("${pkgs.wlogout}/share/wlogout/assets/hibernate.svg");
      }

      #shutdown {
        background-image: url("${pkgs.wlogout}/share/wlogout/assets/shutdown.svg");
      }

      #reboot {
        background-image: url("${pkgs.wlogout}/share/wlogout/assets/reboot.svg");
      }
    '';
  };
}
