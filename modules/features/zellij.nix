{
  inputs,
  ...
}:
{
  flake.modules.homeManager.zellij =
    { pkgs, ... }:
    {
      programs.zellij =
        let
          mod = "Alt"; # Can be one of "Ctrl", "Alt", "Shift", "Super"

          action = name: { ${name} = { }; };
          actionWith = name: args: { ${name}._args = args; };
          switchMode = mode: actionWith "SwitchToMode" [ mode ];
          bind =
            { keys, actions }:
            {
              bind = {
                _args = [ keys ];
                _children = actions;
              };
            };
          modeBinds = mode: bindings: {
            ${mode}._children = map bind bindings;
          };
          sharedExcept = modes: bindings: {
            shared_except = {
              _args = modes;
              _children = map bind bindings;
            };
          };
        in
        {
          enable = true;
          enableZshIntegration = true;
          settings = {
            theme = "catppuccin-mocha";
            show_startup_tips = false;
            default_mode = "locked";

            ui._children = [
              {
                pane_frames._children = [
                  { rounded_corners = true; }
                ];
              }
            ];

            keybinds = {
              _props = {
                clear-defaults = true;
              };

              _children = [
                (modeBinds "locked" [
                  {
                    keys = "${mod} q";
                    actions = [
                      (switchMode "Normal")
                    ];
                  }
                ])
                (sharedExcept
                  [ "locked" "normal" "renamepane" "renametab" ]
                  [
                    {
                      keys = "Esc";
                      actions = [ (switchMode "Normal") ];
                    }
                  ]
                )
                (modeBinds "normal" [
                  {
                    keys = "Esc";
                    actions = [ (switchMode "Locked") ];
                  }
                  {
                    keys = "h";
                    actions = [ (actionWith "MoveFocusOrTab" [ "Left" ]) ];
                  }
                  {
                    keys = "j";
                    actions = [ (actionWith "MoveFocus" [ "Down" ]) ];
                  }
                  {
                    keys = "k";
                    actions = [ (actionWith "MoveFocus" [ "Up" ]) ];
                  }
                  {
                    keys = "l";
                    actions = [ (actionWith "MoveFocusOrTab" [ "Right" ]) ];
                  }
                  {
                    keys = "H";
                    actions = [ (action "GoToPreviousTab") ];
                  }
                  {
                    keys = "L";
                    actions = [ (action "GoToNextTab") ];
                  }
                  {
                    keys = "p";
                    actions = [ (switchMode "Pane") ];
                  }
                  {
                    keys = "t";
                    actions = [ (switchMode "Tab") ];
                  }
                  {
                    keys = "r";
                    actions = [ (switchMode "Resize") ];
                  }
                ])
                (modeBinds "pane" [
                  {
                    keys = "h";
                    actions = [ (actionWith "MovePane" [ "Left" ]) ];
                  }
                  {
                    keys = "j";
                    actions = [ (actionWith "MovePane" [ "Down" ]) ];
                  }
                  {
                    keys = "k";
                    actions = [ (actionWith "MovePane" [ "Up" ]) ];
                  }
                  {
                    keys = "l";
                    actions = [ (actionWith "MovePane" [ "Right" ]) ];
                  }
                  {
                    keys = "s";
                    actions = [
                      (actionWith "NewPane" [ "stacked" ])
                    ];
                  }
                  {
                    keys = "d";
                    actions = [
                      (actionWith "NewPane" [ "down" ])
                    ];
                  }
                  {
                    keys = "r";
                    actions = [
                      (actionWith "NewPane" [ "right" ])
                    ];
                  }
                  {
                    keys = "x";
                    actions = [
                      (action "CloseFocus")
                    ];
                  }
                  {
                    keys = "e";
                    actions = [
                      (action "TogglePaneEmbedOrFloating")
                    ];
                  }
                  {
                    keys = "f";
                    actions = [
                      (action "ToggleFocusFullscreen")
                    ];
                  }
                  {
                    keys = "c";
                    actions = [
                      (switchMode "RenamePane")
                      (actionWith "PaneNameInput" [ 0 ])
                    ];
                  }
                  {
                    keys = "w";
                    actions = [
                      (action "ToggleFloatingPanes")
                    ];
                  }
                  {
                    keys = "[";
                    actions = [
                      (action "BreakPaneLeft")
                    ];
                  }
                  {
                    keys = "]";
                    actions = [
                      (action "BreakPaneRight")
                    ];
                  }
                ])
                (modeBinds "tab" [
                  {
                    keys = "h";
                    actions = [ (actionWith "MoveTab" [ "Left" ]) ];
                  }
                  {
                    keys = "l";
                    actions = [ (actionWith "MoveTab" [ "Right" ]) ];
                  }
                  {
                    keys = "b";
                    actions = [
                      (action "BreakPane")
                    ];
                  }
                  {
                    keys = "x";
                    actions = [
                      (action "CloseTab")
                    ];
                  }
                  {
                    keys = "n";
                    actions = [
                      (action "NewTab")
                    ];
                  }
                  {
                    keys = "c";
                    actions = [
                      (switchMode "RenameTab")
                      (actionWith "TabNameInput" [ 0 ])
                    ];
                  }
                ])
                (modeBinds "renamepane" [
                  {
                    keys = "Enter";
                    actions = [
                      (switchMode "Pane")
                    ];
                  }
                  {
                    keys = "Esc";
                    actions = [
                      (action "UndoRenamePane")
                      (switchMode "Pane")
                    ];
                  }
                ])
                (modeBinds "renametab" [
                  {
                    keys = "Enter";
                    actions = [
                      (switchMode "Tab")
                    ];
                  }
                  {
                    keys = "Esc";
                    actions = [
                      (action "UndoRenameTab")
                      (switchMode "Tab")
                    ];
                  }
                ])
                (modeBinds "resize" [
                  {
                    keys = "h";
                    actions = [ (actionWith "Resize" [ "Increase Left" ]) ];
                  }
                  {
                    keys = "j";
                    actions = [ (actionWith "Resize" [ "Increase Down" ]) ];
                  }
                  {
                    keys = "k";
                    actions = [ (actionWith "Resize" [ "Increase Up" ]) ];
                  }
                  {
                    keys = "l";
                    actions = [ (actionWith "Resize" [ "Increase Right" ]) ];
                  }
                  {
                    keys = "H";
                    actions = [ (actionWith "Resize" [ "Decrease Right" ]) ];
                  }
                  {
                    keys = "J";
                    actions = [ (actionWith "Resize" [ "Decrease Up" ]) ];
                  }
                  {
                    keys = "K";
                    actions = [ (actionWith "Resize" [ "Decrease Down" ]) ];
                  }
                  {
                    keys = "L";
                    actions = [ (actionWith "Resize" [ "Decrease Left" ]) ];
                  }
                  {
                    keys = "+";
                    actions = [ (actionWith "Resize" [ "Increase" ]) ];
                  }
                  {
                    keys = "=";
                    actions = [ (actionWith "Resize" [ "Increase" ]) ];
                  }
                  {
                    keys = "-";
                    actions = [ (actionWith "Resize" [ "Decrease" ]) ];
                  }
                ])
              ];
            };

            plugins = {
              compact-bar = {
                _props = {
                  location = "zellij:compact-bar";
                };
              };
            };

            # simplified_ui = true;
            # pane_frames = true;
            copy_on_select = true;
          };
        };

      xdg.configFile."zellij/layouts/default.kdl".text =
        let
          zjstatus = inputs.zjstatus.packages.${pkgs.stdenv.hostPlatform.system}.default;
        in
        ''
          layout {
            default_tab_template {
              pane size=2 borderless=true {
                plugin location="file:${zjstatus}/bin/zjstatus.wasm" {
                  hide_frame_except_for_search "true"

                  border_enabled  "true"
                  border_char     "─"
                  border_format   "#[fg=#6C7086]{char}"
                  border_position "bottom"

                  format_left   " {mode} #[fg=#6c7086]│ #[fg=#eba0ac] {session}"
                  format_center "{tabs}"
                  format_right  ""
                  format_space  ""

                  format_hide_on_overlength "true"
                  format_precedence         "crl"

                  tab_normal    "#[fg=#f5e0dc] {name}{fullscreen_indicator}{sync_indicator}{floating_indicator} "
                  tab_active    "#[fg=#1e1e2e,bg=#fab387] {name}{fullscreen_indicator}{sync_indicator}{floating_indicator} "
                  tab_fullscreen_indicator " □"
                  tab_sync_indicator       " "
                  tab_floating_indicator   " 󰉈"
                  tab_separator "#[fg=#6C7086] │ "

                  mode_normal        "#[fg=#a6da95]NORMAL"
                  mode_locked        "#[fg=#6e738d]LOCKED "
                  mode_resize        "#[fg=#f38ba8]RESIZE"
                  mode_pane          "#[fg=#89b4fa]PANE"
                  mode_tab           "#[fg=#b4befe]TAB"
                  mode_scroll        "#[fg=#f9e2af]SCROLL"
                  mode_enter_search  "#[fg=#8aadf4]ENT-SEARCH"
                  mode_search        "#[fg=#8aadf4]SEARCHARCH"
                  mode_rename_tab    "#[fg=#b4befe]RENAME-TAB"
                  mode_rename_pane   "#[fg=#89b4fa]RENAME-PANE"
                  mode_session       "#[fg=#74c7ec]SESSION"
                  mode_move          "#[fg=#f5c2e7]MOVE"
                  mode_prompt        "#[fg=#8aadf4]PROMPT"
                  mode_tmux          "#[fg=#f5a97f]TMUX"

                  command_host_command    "uname -n"
                  command_host_format     "{stdout}"
                  command_host_interval   "0"
                  command_host_rendermode "static"

                  command_user_command    "whoami"
                  command_user_format     "{stdout}"
                  command_user_interval   "0"
                  command_user_rendermode "static"
                }
              }
              children
            }
          }
        '';
    };
}
