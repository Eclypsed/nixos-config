{
  flake.modules.nixos.power-management = {
    services = {
      upower.enable = true;

      system76-scheduler.settings.cfsProfiles.enable = true;

      tlp = {
        enable = true;
        settings = {
          CPU_BOOST_ON_AC = 1;
          CPU_BOOST_ON_BAT = 0;
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
          PLATFORM_PROFILE_ON_AC = "performance";
          PLATFORM_PROFILE_ON_BAT = "balanced";
          START_CHARGE_THRESH_BAT1 = 65; # Only STOP_CHARGE_THRESH available on Framework
          STOP_CHARGE_THRESH_BAT1 = 80;
          # Fixes stuttering Hyprland animations on Intel iGPU (https://wiki.hypr.land/Configuring/Performance/)
          INTEL_GPU_MIN_FREQ_ON_AC = 300;
          INTEL_GPU_MIN_FREQ_ON_BAT = 300;
        };
      };

      # Disable GNOME's power management (conflicts with TLP)
      power-profiles-daemon.enable = false;
    };

    powerManagement = {
      enable = true;
      powertop.enable = true;
    };
  };
}
