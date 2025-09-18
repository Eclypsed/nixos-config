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

        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
          registers = "unnamedplus";
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
          setupOpts = {
            git_status_async = true;
          };
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
            key = "<A-e>";
            mode = [ "n" ];
            silent = true;
            action = "<cmd>Neotree focus<CR>";
          }
          {
            key = "<C-e>";
            mode = [ "n" ];
            silent = true;
            action = "<cmd>Neotree close<CR>";
          }
          {
            key = "<C-s>";
            mode = [
              "n"
              "i"
              "v"
            ];
            action = "<cmd>w<CR>";
          }

          # Window Navigation
          {
            key = "<C-w>LEFT";
            mode = "";
            action = "<C-w>h";
          }
          {
            key = "<C-w>DOWN";
            mode = "";
            action = "<C-w>j";
          }
          {
            key = "<C-w>UP";
            mode = "";
            action = "<C-w>k";
          }
          {
            key = "<C-w>RIGHT";
            mode = "";
            action = "<C-w>l";
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

          markdown = {
            enable = true;
            extensions = {
              markview-nvim.enable = true;
            };
            format = {
              enable = true;
            };
            lsp = {
              enable = true;
            };
            treesitter = {
              enable = true;
            };
          };

          html = {
            enable = true;
            treesitter = {
              enable = true;
              autotagHtml = true;
            };
          };
        };

        utility = {
          sleuth.enable = true;
          multicursors.enable = true;
          preview = {
            markdownPreview = {
              enable = true;
              autoClose = true;
            };
          };
        };
      };
    };
  };
}
