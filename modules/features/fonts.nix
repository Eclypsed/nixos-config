{
  flake.modules.homeManager.fonts =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # Maple Mono
        maple-mono.truetype
        maple-mono.NF-unhinted
        maple-mono.NF-CN-unhinted

        # JetBrains Mono
        nerd-fonts.jetbrains-mono

        # Noto
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
      ];

      fonts.fontconfig = {
        enable = true;
        defaultFonts = {
          sansSerif = [ "Noto Sans" ];
          monospace = [
            "Maple Mono"
            "JetBrainsMono Nerd Font"
          ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
    };
}
