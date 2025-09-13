{
  inputs,
  pkgs,
  host,
  ...
}:
{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;

        options = {
          wrap = false;
        };

        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
        };

        treesitter = {
          enable = true;
          indent.enable = true;
        };

        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.blink-cmp.enable = true;

        # Auto-close (, ", `, etc.
        mini.pairs = {
          enable = true;
        };

        # File explorer
        filetree.neo-tree = {
          enable = true;
        };

        # Formatting files
        formatter.conform-nvim = {
          enable = true;
          setupOpts = {

          };
        };

        binds = {
          whichKey.enable = true;
        };

        keymaps = [
          {
            key = "<C-e>";
            mode = [ "n" ];
            silent = true;
            action = "<cmd>Neotree toggle<CR>";
          }
        ];

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
        };

        languages = {
          enableTreesitter = true;
          enableFormat = true;

          nix = {
            enable = true;
            format = {
              enable = true;
              package = pkgs.nixfmt;
              type = "nixfmt";
            };
            lsp = {
              enable = true;
              package = pkgs.nixd;
              server = "nixd";
              options = {
                nixos = {
                  expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${host}.options";
                };
                home-manager = {
                  expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${host}.options.home-manager.users.type.getSubOptions []";
                };
              };
            };
            treesitter.enable = true;
          };

          python = {
            enable = true;
            dap = {
              enable = true;
              debugger = "debugpy";
            };
            format = {
              enable = true;
              type = "black-and-isort";
            };
            lsp = {
              enable = true;
            };
            treesitter.enable = true;
          };
        };

        utility = {
          sleuth.enable = true;
        };
      };
    };
  };
}
