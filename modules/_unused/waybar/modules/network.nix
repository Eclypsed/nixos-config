{
  ...
}:
{
  format = "{ifname}";
  format-wifi = "{icon}";
  format-ethernet = "󰌘";
  format-disconnected = "󰌙";
  format-linked = "󰈁 {ifname} (No IP)";
  tooltip-format = "{ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
  tooltip-format-wifi = "{essid} {icon} {signalStrength}%";
  tooltip-format-ethernet = "{essid} 󰌘";
  tooltip-format-disconnected = "󰌙 Disconnected";
  max-length = 50;
  format-icons = [
    "󰤯"
    "󰤟"
    "󰤢"
    "󰤥"
    "󰤨"
  ];
}
