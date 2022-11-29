''
  * {
    border: none;
    font-family: Material Design Icons, Iosevka Nerd Font;
    /*font-family: FiraCode Nerd Font Mono;*/
    /*font-weight: bold;*/
    font-size: 12px;
    text-shadow: 0px 0px 5px #000000;
  }

  button:hover {
    background-color: rgba(80,100,100,0.4);
  }

  window#waybar {
    background-color: rgba(0,0,0,0.5);
    background: transparent;
    transition-property: background-color;
    transition-duration: .5s;
    border-bottom: none;
  }

  window#waybar.hidden {
    opacity: 0.2;
  }

  #workspace,
  #mode,
  #clock,
  #pulseaudio,
  #custom-sink,
  #network,
  #mpd,
  #memory,
  #network,
  #window,
  #cpu,
  #disk,
  #battery,
  #tray {
    color: #999999;
    background-clip: padding-box;
  }

  #custom-menu {
    color: #A7C7E7;
    padding: 0px 5px 0px 5px;
  }

  #workspaces button {
    padding: 0px 5px;
    min-width: 5px;
    color: rgba(255,255,255,0.8);
  }

  #workspaces button:hover {
    background-color: rgba(0,0,0,0.2);
  }

  /*#workspaces button.focused {*/
  #workspaces button.active {
    color: rgba(255,255,255,0.8);
    background-color: rgba(80,100,100,0.4);
  }

  #workspaces button.visible {
    color: #ccffff;
  }

  #workspaces button.hidden {
    color: #999999;
  }

  #battery.warning {
    color: #ff5d17;
  }

  #battery.critical {
    color: #ff200c;
  }

  #battery.charging {
    color: #9ece6a;
  }
''
