{
  pkgs,
  default,
  ...
}: let
  emoji = "${pkgs.wofi-emoji}/bin/wofi-emoji";
  launcher = "wofi";
in {
  wayland.windowManager.hyprland.extraConfig = ''
    $mod=SUPER

    monitor=eDP-1,2256x1504@60,0x0,1.2
    monitor=eDP-1,addreserved,0,0,50,0

    workspace=eDP-1,1

    exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    # exec-once=eww daemon
    exec-once=eww open bar
    exec-once=swaybg -i $HOME/wallpaper/aenami_escape_1k.jpg --mode fill
    exec-once=mako

    # touchpad gestures
    gestures {
      workspace_swipe = 1
      workspace_swipe_forever = 1
    }

    input {
      kb_layout=us
      kb_options=ctrl:nocaps
      follow_mouse=2
      repeat_rate=50
      repeat_delay=250
      numlock_by_default=1
      force_no_accel=false
      sensitivity=0.33
      accel_profile=adaptive

      touchpad {
        disable_while_typing=true
        clickfinger_behavior=true
      }
    }

    general {
      main_mod=SUPER
      sensitivity=1
      border_size=3
      gaps_in=4
      gaps_out=8
      col.active_border=0x997E9CD8
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

      bezier=easein,0.11, 0, 0.5, 0
      bezier=easeout,0.5, 1, 0.89, 1
      bezier=easeinout,0.45, 0, 0.55, 1

      animation=windowsIn,1,3,easeout,slide
      animation=windowsOut,1,3,easein,slide
      animation=windowsMove,1,3,easeout

      animation=fadeIn,1,3,easeout
      animation=fadeOut,1,3,easein
      animation=fadeSwitch,1,3,easeout
      animation=fadeShadow,1,3,easeout
      animation=fadeDim,1,3,easeout
      animation=border,1,3,easeout

      animation=workspaces,1,2,easeout,slide
    }

    dwindle {
      pseudotile=false
      force_split=2
    }

    debug {
      damage_tracking=2
    }

    windowrule=float,^(Rofi)$
    windowrule=float,title:^(Picture-in-Picture)$
    windowrule=float,title:^(Volume Control)$

    bindm=SUPER,mouse:272,movewindow
    bindm=SUPER,mouse:273,resizewindow

    bind = $mod, Return, exec, alacritty
    bind = $mod, W, exec, makoctl dismiss
    bind = $mod, Q, killactive,
    bind = $mod SHIFT, X, exec, loginctl lock-session
    bind = $mod, Escape, exit,
    bind = $mod, E, exec, pcmanfm
    #bind = $mod, H, togglefloating,
    #bind = $mod, D, exec, rofi -show drun
    bind = $mod, D, exec, wofi --show run --xoffset=1542 --yoffset=8 --width=320px --height=1228px --style=$HOME/.config/wofi.css --prompt=Run
    bind = $mod, P, pseudo,
    bind = $mod, F, fullscreen,
    bind = $mod, R, forcerendererreload
    bind = $mod SHIFT, R, exec, hyprctl reload && notify-send "Hyprland Reloaded"

    bind=SUPER,h,movefocus,l
    bind=SUPER,l,movefocus,r
    bind=SUPER,k,movefocus,u
    bind=SUPER,j,movefocus,d

    bind=SUPERSHIFT,left,movewindow,l
    bind=SUPERSHIFT,right,movewindow,r
    bind=SUPERSHIFT,up,movewindow,u
    bind=SUPERSHIFT,down,movewindow,d

    # Window Resize
    bind=CTRL,right,resizeactive,20 0
    bind=CTRL,left,resizeactive,-20 0
    bind=CTRL,up,resizeactive,0 -20
    bind=CTRL,down,resizeactive,0 20

    # Media

    # Volume
    bindle=,XF86AudioLowerVolume,exec,pamixer -d 10
    bindle=,XF86AudioRaiseVolume,exec,pamixer -i 10
    bindl=,XF86AudioMute,exec,pamixer -t
    bindl=,XF86AudioMicMute,exec,pamixer --default-source -t

    # Backlight
    bindle = , XF86MonBrightnessDown, exec, brightnessctl s 10%-
    bindle = , XF86MonBrightnessUP, exec, brightnessctl s +10%

    # Screenshot
    bind=,print,exec,grim -g "$(slurp)" - | swappy -f - -o ~/Pictures/$(date +%Hh_%Mm_%Ss_%d_%B_%Y).png && notify-send "Saved to ~/Pictures/$(date +%Hh_%Mm_%Ss_%d_%B_%Y).png"

    # Workspaces
    # binds mod + [shift +] {1..10} to [move to] ws {1..10}
    ${builtins.concatStringsSep "\n" (builtins.genList (
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString (x + 1 - (c * 10));
        in ''
          bind = $mod, ${ws},workspace, ${toString (x + 1)}
          bind = $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
        ''
      )
      10)}

    # Special Workspace
    bind = $mod SHIFT, grave, movetoworkspace, special
    bind = $mod, grave, togglespecialworkspace

    # Cycle Workspaces
    bind=$mod, bracketleft, workspace, m-1
    bind=$mod, bracketright, workspace, m+1
    # Cycle Monitors
    bind=$mod SHIFT, braceleft, focusmonitor, l
    bind=$mod SHIFT, braceright, focusmonitor, r
  '';
}
