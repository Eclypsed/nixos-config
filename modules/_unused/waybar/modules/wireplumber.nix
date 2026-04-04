{
  ...
}:
{
  format = "{icon} {volume}% {format_source}";
  format-muted = "󰖁 {format_source}";
  format-source = "󰍬 {volume}%";
  format-source-muted = "󰍭";
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
  };
  scroll-step = 5.0;
  on-click = "pavucontrol -t 3";
  on-click-right = "pavucontrol -t 4";
  tooltip-format = "{node_name} {volume}%\n{source_desc} {source_volume}%";
}
