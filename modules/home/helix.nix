{
  pkgs,
  ...
}:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      basedpyright
      ruff
      # pylyzer
      isort
      black
      nixd
      nixfmt
    ];
    languages = {
      language = [
        {
          name = "python";
          language-servers = [
            "basedpyright"
            "ruff"
            # "pylyzer"
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
      ];
      language-server = {
        basedpyright.config.python.analysis = {
          typeCheckingMode = "strict";
        };
        ruff = {
          command = "ruff";
          args = [ "server" ];
        };
        # pylyzer = {
        #   command = "pylyzer";
        #   args = [ "--server" ];
        # };
        nixd = {
          command = "nixd";
        };
      };
    };
    settings = {
      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = {
          render = true;
        };
      };
      theme = "catppuccin_mocha";
    };
  };
}
