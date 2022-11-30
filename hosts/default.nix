{ lib, inputs, nixpkgs, home-manager, user, location, hyprland, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  laptop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user location hyprland; };
    modules = [
      hyprland.nixosModules.default
      ./laptop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit inputs user; };
          users.${user} = {
            imports = [(./home.nix)] ++ [(import ./laptop/home.nix)];
          };
        };
      }
    ];
  };
}
