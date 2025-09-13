{
  pkgs,
# pkgs-stable,
  ...
}:
# let
#   ms-python-stable = pkgs-stable.vscode-extensions.ms-python;
# in
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

          # Nix
          bbenoist.nix
          jnoortheen.nix-ide

          # Python
          # ms-python-stable.python
          # ms-python-stable.vscode-pylance
          # ms-python-stable.debugpy
          # ms-python-stable.black-formatter
          # ms-python-stable.isort
          # ms-python.python # Currently broken, need to manually install
          # ms-python.black-formatter
          # ms-python.isort

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
          "isort.args" = [ "--profile" "black" ];
          "python.analysis.typeCheckingMode" = "strict";
          "python.languageServer" = "Pylance";
        };
      };
    };
  };
}
