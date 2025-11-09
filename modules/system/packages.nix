{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nur.modules.nixos.default # Adds the NUR overlay
    ../overlays
  ];

  programs = {
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
    zsh.enable = true;
  };

  nixpkgs = {
    # ? For some reason, doing config.allowUnfree does not work
    # ? Maybe becuase it's not an explicit option?
    # ? https://search.nixos.org/options?channel=25.05&show=nixpkgs.config&query=nixpkgs.config
    config = {
      allowUnfree = true;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      git
    ];
    variables = {
      EDITOR = "vim";
    };
  };
}
