{
  inputs,
  pkgs,
  # host,
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
        viAlias = true;
        vimAlias = true;

        # lazy.plugins = {
        #   "kanagawa.nvim" = {
        #     package = pkgs.vimPlugins.kanagawa-nvim;
        #     setupModule = "kanagawa";
        #     after = "vim.cmd(\"colorscheme kanagawa\")";
        #   };
        # };

        options = {
          wrap = true;
        };

        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
          registers = "unnamedplus";
        };

        comments.comment-nvim = {
          enable = true;
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
        };

        binds = {
          whichKey.enable = true;
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
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
            desc = "Save";
            mode = [
              "n"
              "i"
              "v"
            ];
            action = "<cmd>w<CR>";
          }
          {
            key = "<C-z>";
            desc = "Undo";
            mode = [
              "n"
              "i"
              "v"
            ];
            action = "<cmd>u<CR>";
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

        languages = {
          enableTreesitter = true;
          enableFormat = true;

          clang = {
            enable = true;
            cHeader = true;
            dap.enable = true;
            lsp = {
              enable = true;
              servers = [ "clangd" ];
            };
            treesitter.enable = true;
          };

          css = {
            enable = true;
            format = {
              enable = true;
              type = [ "prettier" ];
            };
            lsp.enable = true;
            treesitter.enable = true;
          };

          html = {
            enable = true;
            treesitter = {
              enable = true;
              autotagHtml = true;
            };
          };

          markdown = {
            enable = true;
            extensions = {
              markview-nvim.enable = true;
            };
            format = {
              enable = true;
              type = [ "prettierd" ];
            };
            lsp = {
              enable = true;
            };
            treesitter = {
              enable = true;
            };
          };

          nix = {
            enable = true;
            format = {
              enable = true;
              type = [ "nixfmt" ];
            };
            lsp = {
              enable = true;
              servers = [ "nixd" ];
              # options = {
              #   nixos = {
              #     expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${host}.options";
              #   };
              #   home-manager = {
              #     expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${host}.options.home-manager.users.type.getSubOptions []";
              #   };
              # };
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
              type = [
                "black"
                "isort"
              ];
            };
            lsp = {
              enable = true;
            };
            treesitter.enable = true;
          };

          rust = {
            enable = true;
            # crates = {
            #   enable = true;
            # };
            dap.enable = true;
            format.enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };

          tailwind = {
            enable = true;
            lsp.enable = true;
          };

          ts = {
            enable = true;
            extensions = {
              ts-error-translator.enable = true;
            };
            extraDiagnostics.enable = true;
            format = {
              enable = true;
              type = [ "prettier" ];
            };
            lsp.enable = true;
            treesitter.enable = true;
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
