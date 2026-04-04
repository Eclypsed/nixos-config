{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    pyprland
  ];

  xdg.configFile."hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = ["scratchpads"]

    [scratchpads.term]
    command = "foot --app-id term_dropdown"
    class = "term_dropdown"
    animation = "fromTop"
    margin = 150
    size = "80% 80%"
    max_size = "1920px 1080px"
    multi = false
  '';
}
