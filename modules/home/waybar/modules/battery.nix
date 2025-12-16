{
  full-at ? 100,
  ...
}:
{
  inherit full-at;
  states = {
    # These values are percentages based on `full-at`
    good = 95;
    warning = 30;
    critical = 15;
  };
  format = "{icon} {capacity}%";
  format-charging = " {capacity}%";
  format-plugged = "󱘖 {capacity}%";
  format-full = "{icon} Full";
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
}
