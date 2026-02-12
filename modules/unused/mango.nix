{
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.mango.hmModules.mango
  ];

  wayland.windowManager.mango = {
    enable = true;
    settings = ''
      source=${config.xdg.configHome}/mango/noctalia.conf

      monitorrule=name:eDP-1,width:2256,height:1504,refresh:59.999001,x:0,y:0,scale:1.0,vrr:0,rr:0
      monitorrule=name:LG Electronics LG TV SSCR2 *,width:3840,height:2160,refresh:120.0,x:2256,y:0,scale:1.0,vrr:0,rr:0

      cursor_size=16
      cursor_theme=catppuccin-mocha-dark-cursors

      bind=SUPER,q,killclient
      bind=SUPER,w,spawn,foot
      bind=SUPER,a,spawn,vicinae toggle
      bind=SUPER,Escape,spawn,noctalia-shell ipc call sessionMenu toggle
      bind=SUPER,n,spawn,noctalia-shell ipc call notifications toggleHistory

      bind=SUPER+SHIFT,r,reload_config

      bind=SUPER,t,setlayout,tile
      bind=SUPER,s,setlayout,scroller

      bind=SUPER,f,togglefloating
      bind=SUPER+SHIFT,f,togglefullscreen

      bind=NONE,XF86AudioPrev,spawn,playerctl previous
      bind=NONE,XF86AudioPlay,spawn,playerctl play-pause
      bind=NONE,XF86AudioNext,spawn,playerctl next

      bindl=NONE,XF86AudioRaiseVolume,spawn,pamixer -i 5
      bindl=NONE,XF86AudioLowerVolume,spawn,pamixer -d 5
      bindl=NONE,XF86AudioMute,spawn,pamixer -t
      bindl=ALT,XF86AudioRaiseVolume,spawn,pamixer --default-source -i 5
      bindl=ALT,XF86AudioLowerVolume,spawn,pamixer --default-source -d 5
      bindl=ALT,XF86AudioMute,spawn,pamixer --default-source -t

      bindl=NONE,XF86MonBrightnessUp,spawn,brightnessctl set 5%+
      bindl=NONE,XF86MonBrightnessDown,spawn,brightnessctl set 5%-

      bind=NONE,Print,spawn_shell,grim -g "$(slurp)" - | wl-copy
      bind=SHIFT,Print,spawn_shell,wl-paste | swappy -f -

      bind=SUPER,Up,focusdir,up
      bind=SUPER,Down,focusdir,down
      bind=SUPER,Left,focusdir,left
      bind=SUPER,Right,focusdir,right
      bind=SUPER+SHIFT,Up,exchange_client,up 
      bind=SUPER+SHIFT,Down,exchange_client,down
      bind=SUPER+SHIFT,Left,exchange_client,left
      bind=SUPER+SHIFT,Right,exchange_client,right

      bind=SUPER+CTRL,Left,viewtoleft
      bind=SUPER+CTRL,Right,viewtoright
      bind=SUPER+CTRL+SHIFT,Left,tagtoleft
      bind=SUPER+CTRL+SHIFT,Right,tagtoright

      mousebind=SUPER,btn_left,moveresize,curmove
      mousebind=SUPER,btn_right,moveresize,curresize
      mousebind=SUPER+ALT,btn_left,moveresize,curresize

      bind=SUPER,Tab,toggleoverview

      blur=1
      blur_params_radius=6
      blur_params_num_passes=2

      windowrule=blur:1,unfocused_opacity:0.95,focused_opacity:0.95,appid:foot

      exec-once=${config.xdg.configHome}/mango/autostart.sh
    '';

    autostart_sh = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
      noctalia-shell
    '';
  };
}
