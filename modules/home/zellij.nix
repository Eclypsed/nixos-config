let
  mod = "Alt"; # Can be one of "Ctrl", "Alt", "Shift", "Super"
in
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      show_startup_tips = false;
      keybinds = {
        _props = {
          clear-defaults = true;
        };

        _children = [
          {
            locked._children = [
              {
                bind = {
                  _args = [ "${mod} g" ];
                  _children = [ { SwitchToMode._args = [ "Normal" ]; } ];
                };
              }
            ];
          }
          {
            resize._children = [
              {
                bind = {
                  _args = [ "${mod} r" ];
                  _children = [ { SwitchToMode._args = [ "Normal" ]; } ];
                };
              }
              {
                bind = {
                  _args = [ "h" ];
                  _children = [ { Resize._args = [ "Increase Left" ]; } ];
                };
              }
              {
                bind = {
                  _args = [ "j" ];
                  _children = [ { Resize._args = [ "Increase Down" ]; } ];
                };
              }
              {
                bind = {
                  _args = [ "k" ];
                  _children = [ { Resize._args = [ "Increase Up" ]; } ];
                };
              }
              {
                bind = {
                  _args = [ "l" ];
                  _children = [ { Resize._args = [ "Increase Right" ]; } ];
                };
              }
            ];
          }

          {
            pane._children = [
              {
                bind = {
                  _args = [ "${mod} p" ];
                  _children = [ { SwitchToMode._args = [ "Normal" ]; } ];
                };
              }
              {
                bind = {
                  _args = [ "c" ];
                  _children = [ { Clear = { }; } ];
                };
              }
              {
                bind = {
                  _args = [ "e" ];
                  _children = [
                    { TogglePaneEmbedOrFloating = { }; }
                    { SwitchToMode._args = [ "Normal" ]; }
                  ];
                };
              }
              {
                bind = {
                  _args = [ "f" ];
                  _children = [
                    { ToggleFocusFullscreen = { }; }
                    { SwitchToMode._args = [ "Normal" ]; }
                  ];
                };
              }
              {
                bind = {
                  _args = [ "s" ];
                  _children = [
                    { NewPane._args = [ "stacked" ]; }
                    { SwitchToMode._args = [ "Normal" ]; }
                  ];
                };
              }
              {
                bind = {
                  _args = [ "j" ];
                  _children = [
                    { NewPane._args = [ "Down" ]; }
                    { SwitchToMode._args = [ "Normal" ]; }
                  ];
                };
              }
              {
                bind = {
                  _args = [ "l" ];
                  _children = [
                    { NewPane._args = [ "Right" ]; }
                    { SwitchToMode._args = [ "Normal" ]; }
                  ];
                };
              }
              {
                bind = {
                  _args = [ "n" ];
                  _children = [
                    { NewPane = { }; }
                    { SwitchToMode._args = [ "Normal" ]; }
                  ];
                };
              }
              {
                bind = {
                  _args = [ "p" ];
                  _children = [
                    { SwitchFocus = { }; }
                    { SwitchToMode._args = [ "Normal" ]; }
                  ];
                };
              }
              {
                bind = {
                  _args = [ "r" ];
                  _children = [
                    { SwitchToMode._args = [ "RenamePane" ]; }
                    { PaneNameInput._args = [ 0 ]; }
                  ];
                };
              }
              {
                bind = {
                  _args = [ "w" ];
                  _children = [
                    { ToggleFloatingPanes = { }; }
                    { SwitchToMode._args = [ "Normal" ]; }
                  ];
                };
              }
              {
                bind = {
                  _args = [ "x" ];
                  _children = [
                    { CloseFocus = { }; }
                    { SwitchToMode._args = [ "Normal" ]; }
                  ];
                };
              }
              {
                bind = {
                  _args = [ "z" ];
                  _children = [
                    { TogglePaneFrames = { }; }
                    { SwitchToMode._args = [ "Normal" ]; }
                  ];
                };
              }
            ];
          }
          {
            move._children = [
              {
                bind = {
                  _args = [ "${mod} m" ];
                  _children = [ { SwitchToMode._args = [ "Normal" ]; } ];
                };
              }
              {
                bind = {
                  _args = [ "h" ];
                  _children = [ { MovePane._args = [ "Left" ]; } ];
                };
              }
              {
                bind = {
                  _args = [ "j" ];
                  _children = [ { MovePane._args = [ "Down" ]; } ];
                };
              }
              {
                bind = {
                  _args = [ "k" ];
                  _children = [ { MovePane._args = [ "Up" ]; } ];
                };
              }
              {
                bind = {
                  _args = [ "l" ];
                  _children = [ { MovePane._args = [ "Right" ]; } ];
                };
              }
            ];
          }
          {
            tab._children = [
              {
                bind = {
                  _args = [ "${mod} t" ];
                  _children = [ { SwitchToMode._args = [ "Normal" ]; } ];
                };
              }
              {
                bind = {
                  _args = [ "b" ];
                  _children = [
                    { BreakPane = { }; }
                    { SwitchToMode._args = [ "Normal" ]; }
                  ];
                };
              }
              {
                bind = {
                  _args = [ "h" ];
                  _children = [ { MoveTab._args = [ "Left" ]; } ];
                };
              }
              {
                bind = {
                  _args = [ "l" ];
                  _children = [ { MoveTab._args = [ "Right" ]; } ];
                };
              }
              {
                bind = {
                  _args = [ "n" ];
                  _children = [
                    { NewTab = { }; }
                    { SwitchToMode._args = [ "Normal" ]; }
                  ];
                };
              }
              {
                bind = {
                  _args = [ "r" ];
                  _children = [
                    { SwitchToMode._args = [ "RenameTab" ]; }
                    { TabNameInput._args = [ 0 ]; }
                  ];
                };
              }
              {
                bind = {
                  _args = [ "x" ];
                  _children = [
                    { CloseTab = { }; }
                    { SwitchToMode._args = [ "Normal" ]; }
                  ];
                };
              }
            ];
          }
          {
            renametab._children = [
              {
                bind = {
                  _args = [ "${mod} c" ];
                  _children = [ { SwitchToMode._args = [ "Normal" ]; } ];
                };
              }
              {
                bind = {
                  _args = [ "Esc" ];
                  _children = [
                    { UndoRenameTab = { }; }
                    { SwitchToMode._args = [ "Normal" ]; }
                  ];
                };
              }
            ];
          }
          {
            renamepane._children = [
              {
                bind = {
                  _args = [ "${mod} c" ];
                  _children = [ { SwitchToMode._args = [ "Normal" ]; } ];
                };
              }
              {
                bind = {
                  _args = [ "Esc" ];
                  _children = [
                    { UndoRenamePane = { }; }
                    { SwitchToMode._args = [ "Normal" ]; }
                  ];
                };
              }
            ];
          }
          {
            shared_except = {
              _args = [ "locked" ];
              _children = [
                {
                  bind = {
                    _args = [ "${mod} g" ];
                    _children = [ { SwitchToMode._args = [ "Locked" ]; } ];
                  };
                }
                {
                  bind = {
                    _args = [ "${mod} h" ];
                    _children = [ { MoveFocusOrTab._args = [ "Left" ]; } ];
                  };
                }
                {
                  bind = {
                    _args = [ "${mod} l" ];
                    _children = [ { MoveFocusOrTab._args = [ "Right" ]; } ];
                  };
                }
                {
                  bind = {
                    _args = [ "${mod} j" ];
                    _children = [ { MoveFocus._args = [ "Down" ]; } ];
                  };
                }
                {
                  bind = {
                    _args = [ "${mod} k" ];
                    _children = [ { MoveFocus._args = [ "Up" ]; } ];
                  };
                }
                {
                  bind = {
                    _args = [ "${mod} [" ];
                    _children = [ { PreviousSwapLayout = { }; } ];
                  };
                }
                {
                  bind = {
                    _args = [ "${mod} ]" ];
                    _children = [ { NextSwapLayout = { }; } ];
                  };
                }
              ];
            };
          }
          {
            shared_except = {
              _args = [
                "normal"
                "locked"
              ];
              _children = [
                {
                  bind = {
                    _args = [
                      "Enter"
                      "Esc"
                    ];
                    _children = [ { SwitchToMode = [ "Normal" ]; } ];
                  };
                }
              ];
            };
          }
          {
            shared_except = {
              _args = [
                "pane"
                "locked"
              ];
              _children = [
                {
                  bind = {
                    _args = [ "${mod} p" ];
                    _children = [ { SwitchToMode = [ "Pane" ]; } ];
                  };
                }
              ];
            };
          }
          {
            shared_except = {
              _args = [
                "resize"
                "locked"
              ];
              _children = [
                {
                  bind = {
                    _args = [ "${mod} r" ];
                    _children = [ { SwitchToMode = [ "Resize" ]; } ];
                  };
                }
              ];
            };
          }
          {
            shared_except = {
              _args = [
                "tab"
                "locked"
              ];
              _children = [
                {
                  bind = {
                    _args = [ "${mod} t" ];
                    _children = [ { SwitchToMode = [ "Tab" ]; } ];
                  };
                }
              ];
            };
          }
          {
            shared_except = {
              _args = [
                "move"
                "locked"
              ];
              _children = [
                {
                  bind = {
                    _args = [ "${mod} m" ];
                    _children = [ { SwitchToMode = [ "Move" ]; } ];
                  };
                }
              ];
            };
          }
        ];
      };

      plugins = {
        compact-bar = {
          _props = {
            location = "zellij:compact-bar";
          };
        };
      };

      simplified_ui = true;
      pane_frames = false;
      copy_on_select = true;
    };
  };
}
