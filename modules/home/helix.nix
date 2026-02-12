{
  pkgs,
  ...
}:
let
  yazi-picker = pkgs.writeShellApplication {
    name = "yazi-picker";
    text = ''
      paths=$(yazi --chooser-file=/dev/stdout)

      if [[ -n "$paths" ]]; then
        zellij action toggle-floating-panes
      	zellij action write 27 # send <Escape> key
      	zellij action write-chars ":$1 $paths"
      	zellij action write 13 # send <Enter> key
      else
      	zellij action toggle-floating-panes
      fi
    '';
  };
in
{
  home.packages = [ yazi-picker ];

  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      basedpyright
      ruff
      isort
      black
      nixd
      nixfmt
      rust-analyzer
      rustfmt
    ];
    languages = {
      language = [
        {
          name = "python";
          language-servers = [
            "basedpyright"
            "ruff"
          ];
          auto-format = true;
          formatter = {
            command = "bash"; # We have to use bash to call both isort and black
            args = [
              "-c"
              "isort --profile black - | black --quiet --line-length=79 -" # Line length of 79 in accordance with PEP 8
            ];
          };
        }
        {
          name = "nix";
          language-servers = [ "nixd" ];
          auto-format = true;
          formatter = {
            command = "nixfmt";
          };
        }
        {
          name = "rust";
          language-servers = [ "rust-analyzer" ];
          auto-format = true;
          roots = [
            "Cargo.toml"
            "Cargo.lock"
          ];
          formatter = {
            command = "rustfmt";
          };
        }
      ];
      language-server = {
        basedpyright.config.python.analysis = {
          typeCheckingMode = "strict";
        };
        ruff = {
          command = "ruff";
          args = [ "server" ];
        };
        nixd = {
          command = "nixd";
        };
        rust-analyzer = {
          command = "rust-analyzer";
          config = {
            inlayHints = {
              bindingModeHints.enable = false;
              closingBraceHints.minLines = 10;
              closureReturnTypeHints.enable = "with_block";
              discriminantHints.enable = "fieldless";
              lifetimeElisionHints.enable = "skip_trivial";
              typeHints.hideClosureInitialization = false;
            };
          };
        };
      };
    };
    settings = {
      editor = {
        bufferline = "always";
        completion-timeout = 5;
        completion-trigger-len = 1;
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        lsp = {
          display-inlay-hints = true;
        };
        indent-guides = {
          render = true;
          skip-levels = 1;
        };
        soft-wrap = {
          enable = true;
          max-indent-retain = 80;
        };
      };
      keys = {
        normal = {
          "C-y" =
            ":sh zellij run -n Yazi -c -f -x 10%% -y 10%% --width 80%% --height 80%% -- yazi-picker open %{buffer_name}";
        };
      };
      theme = "catppuccin_mocha";
    };
  };
}
