{
  inputs,
  ...
}:
{
  imports = [
    inputs.mango.hmModules.mango
  ];

  wayland.windowManager.mango = {
    enable = true;
    settings = ''
      bind=SUPER,Return,spawn,alacritty
      bind=SUPER,s,spawn,rofi -show drun

      bind=SUPER,q,killclient
      bind=SUPER+SHIFT,r,reload_config

      bind=SUPER,t,setlayout,tile
      bind=SUPER,v,setlayout,vertical_grid
      bind=SUPER,c,setlayout,spiral
      bind=SUPER,x,setlayout,scroller
      bind=SUPER,n,switch_layout
      bind=SUPER,a,togglegaps

      bind=SUPER,Up,focusdir,up
      bind=SUPER,Down,focusdir,down
      bind=SUPER,Left,focusdir,left
      bind=SUPER,Right,focusdir,right

      bind=SUPER+SHIFT,Up,exchange_client,up 
      bind=SUPER+SHIFT,Down,exchange_client,down
      bind=SUPER+SHIFT,Left,exchange_client,left
      bind=SUPER+SHIFT,Right,exchange_client,right
    '';
  };
}
