{
  pkgs,
  inputs,
  username,
  ...
}:
{
  imports = [
    inputs.nix-jmu-cs345.homeManagerModules.bernstdh
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.11";

  # Configure default user packages.
  home.packages = with pkgs; [
    neofetch
    discord
    obsidian
    zoom-us
    kitty
    soulseekqt
    puddletag
  ];

  # Enable CS345 dev environment
  programs.nix-jmu-cs345.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Eclypsed";
    userEmail = "Ec1ypsed@proton.me";
    # extraConfig = {
    #   init = {
    #     defaultBranch = "main";
    #   };
    #   credential = {
    #     helper = [
    #       "cache --timeout 21600"
    #       "oauth"
    #     ];
    #   };
    # };
  };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    colorschemes.dracula-nvim = {
      enable = true;
    };

    plugins = {
      nix.enable = true;
      lsp = {
        enable = true;
        servers = {
          ts_ls.enable = true;
          nixd = {
            enable = true;
            settings = {
              formatting.command = [ "nixfmt" ];
            };
          };
        };

        onAttach = ''
          vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function(args)
              local client = vim.lsp.get_active_clients({ bufnr = args.buf })[1]
              if client and client.supports_method("textDocument/formatting") then
                vim.lsp.buf.format({ bufnr = args.buf })
              end
            end,
          })
        '';
      };
    };

    userCommands = {
      Format = {
        command = "lua vim.lsp.buf.format({ async = false })";
      };
    };
  };

  # programs.neovim = {
  #   enable = true;
  #   defaultEditor = true;
  #   viAlias = true;
  #   vimAlias = true;
  #   vimdiffAlias = true;
  #   extraConfig = ''
  #     set clipboard=unnamedplus
  #     set number
  #     colorscheme Monokai
  #     map <F4> :call NextColorScheme()<CR>
  #     map <F3> :call PreviousColorScheme()<CR>
  #   '';
  #   plugins = with pkgs.vimPlugins; [
  #     vim-lastplace
  #     vim-nix
  #     vim-colorschemes
  #     changeColorScheme-vim
  #   ];
  # };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      svelte.svelte-vscode
      ms-python.python
      esbenp.prettier-vscode
      yoavbls.pretty-ts-errors
      pkief.material-icon-theme
      ritwickdey.liveserver
      jnoortheen.nix-ide
    ];
  };
}
