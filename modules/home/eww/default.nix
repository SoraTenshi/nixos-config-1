{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  dependencies = with pkgs; [
    config.programs.eww.package
  ];
in {
  programs.eww = {
    enable = true;
    package = inputs.eww.packages.${pkgs.system}.eww-wayland;
    # Use all non-nix files
    configDir = lib.cleanSourceWith {
      filter = name: _type: let
        baseName = baseNameOf (toString name);
      in
        !(lib.hasSuffix ".nix" baseName);
      src = lib.cleanSource ./.;
    };
  };

  systemd.user.services.eww = {
    Unit = {
      Description = "Eww Daemon";
      # not yet implemented
      # PartOf = ["tray.target"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      Environment = "PATH=/run/wrappers/bin:${lib.makeBinPath dependencies}";
      ExecStart = "${config.programs.eww.package}/bin/eww daemon --no-daemonize";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
  # eww package
  # home.packages = with pkgs; [
  #     eww-wayland
  #     pamixer
  #     brightnessctl
  #     (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  # ];
  #
  # # configuration
  # home.file.".config/eww/eww.scss".source = ./eww.scss;
  # home.file.".config/eww/eww.yuck".source = ./eww.yuck;
  #
  # # scripts
  # home.file.".config/eww/scripts/battery.sh" = {
  #     source = ./scripts/battery.sh;
  #     executable = true;
  # };
  #
  # home.file.".config/eww/scripts/wifi.sh" = {
  #     source = ./scripts/wifi.sh;
  #     executable = true;
  # };
  #
  # home.file.".config/eww/scripts/brightness.sh" = {
  #     source = ./scripts/brightness.sh;
  #     executable = true;
  # };
  #
  # home.file.".config/eww/scripts/workspaces.sh" = {
  #     source = ./scripts/workspaces.sh;
  #     executable = true;
  # };
  #
  # home.file.".config/eww/scripts/workspaces.lua" = {
  #     source = ./scripts/workspaces.lua;
  #     executable = true;
  # };

}
