
#  Hyprland NixOS & Home manager configuration
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./laptop
#   │       └─ home.nix
#   └─ ./modules
#       └─ ./desktop
#           └─ ./hyprland
#               └─ home.nix *
#

{ config, lib, pkgs, ... }:

{
  home.file = {
    ".config/hypr/hyprland.conf".text = ''
      monitor=eDP-1,2256x1504@60,0x0,1.2
      monitor=eDP-1,addreserved,0,0,48,0
      #monitor=HDMI-A-3,1920x1080@60,1920x0,1
      #monitor=HDMI-A-1,1280x1028@60,3840x0,1

      #workspace=HDMI-A-3,1
      workspace=eDP-1,1
      #workspace=HDMI-A-1,3

      exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once=eww daemon
      exec-once=eww open bar
      exec-once=${pkgs.swaybg}/bin/swaybg -i $HOME/wallpaper/aenami_escape_1k.jpg --mode fill
      #exec-once=${pkgs.waybar}/bin/waybar
      #exec-once=${pkgs.swaybg}/bin/swaybg -m center -i $HOME/.config/wall
      #exec-once=${pkgs.mpvpaper}/bin/mpvpaper -sf -v -o "--loop --panscan=1" '*' $HOME/.config/wall.mp4
      #exec-once=${pkgs.blueman}/bin/blueman-applet

      #wsbind=1,HDMI-A-3
      #wsbind=2,HDMI-A-3
      #wsbind=3,HDMI-A-3
      #wsbind=4,HDMI-A-3
      #wsbind=5,HDMI-A-3
      #wsbind=6,DP-1
      #wsbind=7,DP-1
      #wsbind=8,DP-1
      #wsbind=9,DP-1
      #wsbind=10,DP-1

      general {
        sensitivity=1
        main_mod=SUPER
        border_size=3
        gaps_in=6
        gaps_out=7
        col.active_border=0x80ffffff
        col.inactive_border=0x66333333
        layout=dwindle
      }
      
      decoration {
        rounding=0
        multisample_edges=true
        active_opacity=0.93
        inactive_opacity=0.93
        fullscreen_opacity=1
        blur=true
        drop_shadow=false
      }

      animations {
        enabled=true

        bezier = myBezier,0.1,0.7,0.1,1.05
        bezier=easeout,0.5, 1, 0.89, 1

        animation=fade,1,7,default
        animation=windows,1,7,myBezier
        animation=windowsOut,1,3,default,popin 60%
        animation=windowsMove,1,7,myBezier

        animation=workspaces,1,2,easeout,slide
      }

      input {
        kb_layout=us
        kb_options=ctrl:nocaps
        follow_mouse=2
        repeat_rate=50
        repeat_delay=250
        numlock_by_default=1
        force_no_accel=1
        sensitivity=1
        accel_profile=adaptive

        touchpad {
          disable_while_typing=true
          clickfinger_behavior=true
        }
      }

      dwindle {
        pseudotile=false
        force_split=2
      }

      debug {
        damage_tracking=2
      }

      $mod=SUPER

      bindm=SUPER,mouse:272,movewindow
      bindm=SUPER,mouse:273,resizewindow

      bind=SUPER,Return,exec,${pkgs.alacritty}/bin/alacritty
      bind=SUPER,Q,killactive,
      bind=SUPER,Escape,exit,
      bind=SUPER,E,exec,${pkgs.pcmanfm}/bin/pcmanfm
      #bind=SUPER,H,togglefloating,
      bind=SUPER,D,exec,${pkgs.rofi}/bin/rofi -show drun
      bind=SUPER,P,pseudo,
      bind=SUPER,F,fullscreen,
      bind=SUPER,R,forcerendererreload
      bind=SUPERSHIFT,R,exec,${pkgs.hyprland}/bin/hyprctl reload

      bind=SUPER,h,movefocus,l
      bind=SUPER,l,movefocus,r
      bind=SUPER,k,movefocus,u
      bind=SUPER,j,movefocus,d

      bind=SUPERSHIFT,left,movewindow,l
      bind=SUPERSHIFT,right,movewindow,r
      bind=SUPERSHIFT,up,movewindow,u
      bind=SUPERSHIFT,down,movewindow,d

      bind=$mod,1,workspace,1
      bind=$mod,2,workspace,2
      bind=$mod,3,workspace,3
      bind=$mod,4,workspace,4
      bind=$mod,5,workspace,5
      bind=$mod,6,workspace,6
      bind=$mod,7,workspace,7
      bind=$mod,8,workspace,8
      bind=$mod,9,workspace,9
      bind=$mod,0,workspace,10
      bind=$mod,right,workspace,+1
      bind=$mod,left,workspace,-1

      bind=$mod SHIFT,1,movetoworkspace,1
      bind=$mod SHIFT,2,movetoworkspace,2
      bind=$mod SHIFT,3,movetoworkspace,3
      bind=$mod SHIFT,4,movetoworkspace,4
      bind=$mod SHIFT,5,movetoworkspace,5
      bind=$mod SHIFT,6,movetoworkspace,6
      bind=$mod SHIFT,7,movetoworkspace,7
      bind=$mod SHIFT,8,movetoworkspace,8
      bind=$mod SHIFT,9,movetoworkspace,9
      bind=$mod SHIFT,0,movetoworkspace,10
      bind=$mod SHIFT,right,movetoworkspace,+1
      bind=$mod SHIFT,left,movetoworkspace,-1

      #bind=ALTSHIFT,1,movetoworkspace,1
      #bind=ALTSHIFT,2,movetoworkspace,2
      #bind=ALTSHIFT,3,movetoworkspace,3
      #bind=ALTSHIFT,4,movetoworkspace,4
      #bind=ALTSHIFT,5,movetoworkspace,5
      #bind=ALTSHIFT,6,movetoworkspace,6
      #bind=ALTSHIFT,7,movetoworkspace,7
      #bind=ALTSHIFT,8,movetoworkspace,8
      #bind=ALTSHIFT,9,movetoworkspace,9
      #bind=ALTSHIFT,0,movetoworkspace,10
      #bind=ALTSHIFT,right,movetoworkspace,+1
      #bind=ALTSHIFT,left,movetoworkspace,-1

      bind=CTRL,right,resizeactive,20 0
      bind=CTRL,left,resizeactive,-20 0
      bind=CTRL,up,resizeactive,0 -20
      bind=CTRL,down,resizeactive,0 20

      bind=,print,exec,${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f - -o ~/Pictures/$(date +%Hh_%Mm_%Ss_%d_%B_%Y).png && notify-send "Saved to ~/Pictures/$(date +%Hh_%Mm_%Ss_%d_%B_%Y).png"

      bind=,XF86AudioLowerVolume,exec,${pkgs.pamixer}/bin/pamixer -d 10
      bind=,XF86AudioRaiseVolume,exec,${pkgs.pamixer}/bin/pamixer -i 10
      bind=,XF86AudioMute,exec,${pkgs.pamixer}/bin/pamixer -t
      bind=,XF86AudioMicMute,exec,${pkgs.pamixer}/bin/pamixer --default-source -t
      bind=,XF86MonBrightnessDown,exec,${pkgs.light}/bin/light -U 5
      bind=,XF86MonBrightnessUP,exec,${pkgs.light}/bin/light -A 5

      windowrule=float,^(Rofi)$
      windowrule=float,title:^(Picture-in-Picture)$
      windowrule=float,title:^(Volume Control)$

    '';
  };
}

