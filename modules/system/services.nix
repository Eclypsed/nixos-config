{
  pkgs,
  ...
}:
{
  services = {
    xserver = {
      # Enable the X11 windowing system.
      # You can disable this if you're only using the Wayland session.
      enable = false;

      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    # Enable CUPS to print documents.
    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        cnijfilter2
      ];
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      # jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      # media-session.enable = true;
    };

    upower.enable = true;

    # Disable SSH daemon but generate host keys anyway for secret rekeying
    openssh = {
      enable = false;
      generateHostKeys = true;
    };

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

    # Enable thermald (only necessary for Intel CPUs)
    thermald.enable = true;
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    sane = {
      enable = true;
    };
  };
}
