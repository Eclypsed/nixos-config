{
  flake.modules.homeManager.helix =
    {
      config,
      pkgs,
      lib,
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
      programs.helix = {
        enable = true;
        defaultEditor = true;
        extraPackages = with pkgs; [
          basedpyright # Python static type checker
          ruff # Pyhton linter and formatter
          nixd # Nix language server
          nixfmt # Nix formatter
          rust-analyzer # Rust language server
          rustfmt # Rust formmater
          clippy # Rust linter
          lldb # Debugger for llvm languages
          marksman # Markdown language server
          markdown-oxide # Markdown PKM language server
          rumdl # Markdown linter and formatter
          libclang # C language family frontend for LLVM
          typescript-language-server # Typescript language server
          vscode-langservers-extracted # HTML/CSS/JSON/ESLint language servers extracted from vscode
          emmet-language-server # Emmet support based on LSP
          prettier # Formatter for HTML/CSS/JSON/ESLint languages
          superhtml # HTML Language server and Templating Language Library
          ruby-lsp # Ruby language server
          solargraph # Alternative  ruby language server
          rubocop # Ruby linter and formatter
          jdt-language-server # Java language server
        ];
        settings = {
          editor = {
            line-number = "relative";
            cursorline = true;
            auto-format = true;
            completion-timeout = 5;
            completion-trigger-len = 1;
            bufferline = "always";
            color-modes = true;
            end-of-line-diagnostics = "hint";
            lsp = {
              display-inlay-hints = true;
            };
            cursor-shape = {
              insert = "bar";
              normal = "block";
              select = "underline";
            };
            indent-guides = {
              render = true;
              skip-levels = 1;
            };
            soft-wrap = {
              enable = true;
              max-indent-retain = 80;
            };
            inline-diagnostics = {
              cursor-line = "warning";
            };
          };
          keys =
            let
              arrow_keys = {
                "up" = "jump_view_up";
                "down" = "jump_view_down";
                "left" = "jump_view_left";
                "right" = "jump_view_right";
              };
            in
            {
              normal = {
                "C-y" =
                  if (config.programs.zellij.enable) then
                    ":sh zellij run -n Yazi -c -f -x 10%% -y 10%% --width 80%% --height 80%% -- ${lib.getExe yazi-picker} open \"%{buffer_name}\""
                  else
                    [
                      ":sh rm -f /tmp/unique-ca1ea106"
                      ":insert-output yazi \"%{buffer_name}\" --chooser-file=/tmp/unique-ca1ea106"
                      ":sh printf \"\\x1b[?1049h\\x1b[?2004h\" > /dev/tty"
                      ":open %sh{cat /tmp/unique-ca1ea106}"
                      ":redraw"
                      ":set mouse false"
                      ":set mouse true"
                    ];
              }
              // arrow_keys;
              insert = {
                "C-k" = "move_visual_line_up";
                "C-j" = "move_visual_line_down";
                "C-h" = "move_char_left";
                "C-l" = "move_char_right";
              }
              // arrow_keys;
              select = { } // arrow_keys;
            };
          theme = "catppuccin_mocha";
        };
        # Check https://github.com/helix-editor/helix/blob/master/languages.toml for default language configuration
        # Only explictly set options you want to override / make explicit
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
                command = "ruff";
                args = [
                  "format"
                  "-"
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
              auto-format = true;
              formatter = {
                command = "rustfmt";
              };
            }
            {
              name = "markdown";
              auto-format = true;
              formatter = {
                command = "rumdl";
                args = [
                  "fmt"
                  "-"
                ];
              };
            }
            {
              name = "c";
              file-types = [
                "c"
                "h"
              ]; # "h" is currently missing from the default config
              auto-format = true;
              formatter = {
                command = "clang-format";
                args = [
                  "--style=WebKit"
                ];
              };
            }
            {
              name = "typescript";
              language-servers = [
                "typescript-language-server"
                "vscode-eslint-language-server"
                "emmet-language-server"
              ];
              auto-format = true;
              formatter = {
                command = "prettier";
                args = [
                  "--parser"
                  "typescript"
                ];
              };
            }
            {
              name = "tsx";
              language-servers = [
                "typescript-language-server"
                "vscode-eslint-language-server"
                "emmet-language-server"
              ];
              auto-format = true;
              formatter = {
                command = "prettier";
                args = [
                  "--parser"
                  "typescript"
                ];
              };
            }
            {
              name = "javascript";
              language-servers = [
                "typescript-language-server"
                "vscode-eslint-language-server"
                "emmet-language-server"
              ];
              auto-format = true;
              formatter = {
                command = "prettier";
                args = [
                  "--parser"
                  "typescript"
                ];
              };
            }
            {
              name = "jsx";
              language-servers = [
                "typescript-language-server"
                "vscode-eslint-language-server"
                "emmet-language-server"
              ];
              auto-format = true;
              formatter = {
                command = "prettier";
                args = [
                  "--parser"
                  "typescript"
                ];
              };
            }
            {
              name = "json";
              auto-format = true;
              formatter = {
                command = "prettier";
                args = [
                  "--parser"
                  "json"
                ];
              };
            }
            {
              name = "jsonc";
              auto-format = true;
              formatter = {
                command = "prettier";
                args = [
                  "--parser"
                  "jsonc"
                ];
              };
            }
            {
              name = "html";
              language-servers = [
                "vscode-html-language-server"
                {
                  name = "superhtml";
                  except-features = [ "format" ];
                }
                "emmet-language-server"
              ];
              auto-format = true;
              formatter = {
                command = "prettier";
                args = [
                  "--parser"
                  "html"
                ];
              };
            }
            {
              name = "css";
              language-servers = [
                "vscode-css-language-server"
                "emmet-language-server"
              ];
              auto-format = true;
              formatter = {
                command = "prettier";
                args = [
                  "--parser"
                  "css"
                ];
              };
            }
            {
              name = "scss";
              language-servers = [
                "vscode-css-language-server"
                "emmet-language-server"
              ];
              auto-format = true;
              formatter = {
                command = "prettier";
                args = [
                  "--parser"
                  "scss"
                ];
              };
            }
            {
              name = "ruby";
              language-servers = [
                "ruby-lsp"
                "solargraph"
              ];
              auto-format = true;
              formatter = {
                command = "rubocop";
                args = [
                  "--stdin"
                  "placeholder.rb"
                  "-a"
                  "--stderr"
                  "--fail-level"
                  "fatal"
                ];
              };
            }
          ];
          language-server = {
            basedpyright.config.python.analysis.typeCheckingMode = "strict";
            rust-analyzer.config.check.command = "clippy";
            emmet-language-server = {
              command = "emmet-language-server";
              args = [ "--stdio" ];
            };
            vscode-eslint-language-server = {
              config = {
                # Automatically fix ESLint errors
                codeActionsOnSave = {
                  mode = "all";
                  "source.fixAll.eslint" = true;
                };
                quiet = false;
                experimental = {
                  # Support for the modern ESLint configuration format
                  useFlatConfig = true;
                };
              };
            };
            ruby-lsp = {
              command = "ruby-lsp";
              config = {
                diagnostics = true;
                formatting = true;
              };
            };
            solargraph = {
              command = "solargraph";
              config = {
                diagnostics = true;
                formatting = false;
              };
            };
          };
        };
      };
    };
}
