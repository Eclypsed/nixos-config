{
  flake.modules.homeManager.cd-audio-tools =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        picard
        heybrochecklog
        rsgain
      ];
    };
}
