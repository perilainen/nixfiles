{ pkgs, config, ... }:
let
  # List all `.nix` files in the current directory
  nixFiles = builtins.filter (file: builtins.match ".*\\.nix$" file != null) (builtins.attrNames (builtins.readDir ./.));
in
{
  # Dynamically import all `.nix` files except `default.nix`
  imports = map (file: import ./${file} { inherit pkgs config; }) (builtins.filter (file: file != "default.nix") nixFiles);
}
