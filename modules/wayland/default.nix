{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [./fonts.nix ./services.nix];
}
