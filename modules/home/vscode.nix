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
          "workbench.iconTheme" = "material-icon-theme";

          # Python
          "[python]" = {
            "editor.defaultFormatter" = "ms-python.black-formatter";
            "editor.formatOnSave" = true;
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
        };
      };
    };
  };
}
