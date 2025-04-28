{ config, lib, pkgs, nixvim, ... }:

{
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  options.nixvim.enable = lib.mkEnableOption "Enable and configure Neovim using nixvim";

  config = lib.mkIf config.nixvim.enable {
   programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      colorschemes.catppuccin = {
        enable = true;
        # settings = {
          # flavour = "mocha";
	  # styles = {
          #   booleans = [
          #     "bold"
	  #     "italic"
	  #   ];
	  #   conditionals = [
	  #     "bold"
	  #   ];
	  # };
	  # term_colors = true;
        # };
      };

      plugins = {
        lualine.enable = true;
        telescope.enable = true;
        treesitter.enable = true;
      };
    };
  };

}
