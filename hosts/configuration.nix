# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, user, location, ... }:

{
  imports =
    ( import ../modules/shell );

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };
  security.sudo.wheelNeedsPassword = false;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.utf8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security.rtkit.enable = true;

  fonts = {
    fonts = with pkgs; [
      material-icons
      material-design-icons
      carlito
      vegur
      inter
      iosevka-bin
      lato
      source-code-pro
      noto-fonts
      noto-fonts-emoji
      font-awesome
      jetbrains-mono
      corefonts
      (nerdfonts.override {
        fonts = [
          "Iosevka"
          "JetBrainsMono"
          "FiraCode"
        ];
      })
    ];

    enableDefaultFonts = false;

    fontconfig = {
      defaultFonts ={
        monospace = [
          "Iosevka Term"
          "Iosevka Term Nerd Font Complete Mono"
          "Iosevka Nerd Font"
          "Noto Color Emoji"
        ];
        sansSerif = ["Noto Sans" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  environment = {
    variables = {
      NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
      BAT_THEME="gruvbox-dark";
    };
    systemPackages = with pkgs; [
      killall
      nano
      pciutils
      rust-bin.stable.latest.default
      tailscale
      usbutils
      wget
    ];
  };

  hardware.pulseaudio.enable = false;

  services = {

    # Enable sound with pipewire.
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };

    flatpak.enable = true;
    openssh.enable = true;
    printing.enable = true;

    tailscale.enable = true;
  };

  networking = {
    #wireless.iwd.enable = true;
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
      allowedTCPPorts = [ 22 ];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;

    overlays = with inputs; [
      rust-overlay.overlays.default
    ];
  };

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  system = {
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "22.05";
  };
}
