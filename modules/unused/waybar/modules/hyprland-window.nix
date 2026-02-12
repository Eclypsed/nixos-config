{
  ...
}:
{
  format = "{title}";
  max-length = 40;
  separate-outputs = true; # List different titles for each monitor
  offscreen-css = true; # No idea what this does
  offscreen-css-text = "(inactive)"; # No idea what this does either
  rewrite = {
    "(.*) — Mozilla Firefox" = " Firefox";
    # Foot terminal doesn't display any title for some reason
    # Find a fix
  };
}
