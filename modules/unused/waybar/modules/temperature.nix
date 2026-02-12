{
  ...
}:
{
  interval = 10;
  tooltip = true;
  # Thermal Zone 12 refers to the CPU package temp
  # This might vary between devices. Maybe make it an input?
  thermal-zone = 12;
  critical-threshold = 85;
  format-critical = "{temperatureC}°C {icon}";
  format = "{temperatureC}°C {icon}";
  format-icons = [ "󰈸" ];
}
