{
  ...
}:
{
  active-only = false; # Show all workspaces
  all-outputs = true; # Show all workspace groups
  format = "{icon}";
  show-special = false; # Hide Hyprland's "special" workspaces
  on-click = "activate";
  on-scroll-up = "hyprctl dispatch workspace r+1";
  on-scroll-down = "hyprctl dispatch workspace r-1";
  persistent-workspaces = {
    "1" = [ ];
    "2" = [ ];
    "3" = [ ];
    "4" = [ ];
    "5" = [ ];
  };
  format-icons = {
    active = "";
    default = "";
  };
}
