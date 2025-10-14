{
  pkgs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    profiles = {
      default = {
        enableExtensionUpdateCheck = false;
        enableUpdateCheck = false;
        extensions = with pkgs.vscode-extensions; [
          # General
          pkief.material-icon-theme
          ritwickdey.liveserver
          aaron-bond.better-comments
          yzane.markdown-pdf
          mechatroner.rainbow-csv

          # Remote development
          ms-vscode-remote.remote-ssh
          ms-vscode-remote.remote-ssh-edit
          ms-vscode.remote-explorer

          # Nix
          bbenoist.nix
          jnoortheen.nix-ide

          # Python
          ms-python.python
          ms-python.vscode-pylance
          ms-python.debugpy
          ms-python.black-formatter
          ms-python.isort

          # Rust
          rust-lang.rust-analyzer

          # Typescript / WebDev
          esbenp.prettier-vscode
          yoavbls.pretty-ts-errors
          svelte.svelte-vscode
        ];
        userSettings = {
          # General
          "editor.formatOnSave" = true;
          "workbench.iconTheme" = "material-icon-theme";

          # Prettier
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "prettier.bracketSpacing" = true;
          "prettier.printWidth" = 100;
          "prettier.semi" = false;
          "prettier.singleQuote" = true;
          "prettier.tabWidth" = 4;

          # Python
          "[python]" = {
            "editor.defaultFormatter" = "ms-python.black-formatter";
            "editor.codeActionsOnSave" = {
              "source.organizeImports" = "explicit";
            };
          };
          "isort.args" = [
            "--profile"
            "black"
          ];
          "python.analysis.typeCheckingMode" = "strict";
          "python.languageServer" = "Pylance";

          # JSON
          "[json]" = {
            "prettier.tabWidth" = 2;
          };
          "[jsonc]" = {
            "prettier.tabWidth" = 2;
          };

          # Svelte
          "[svelte]" = {
            "editor.defaultFormatter" = "svelte.svelte-vscode";
          };
          "svelte.enable-ts-plugin" = true;

          # C / C++
          "C_Cpp.clang_format_style" = "GNU"; # This is really just for cs361, I actually hate the GNU style
        };
      };
    };
  };
}
