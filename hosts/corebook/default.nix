{ ... }:
{
  imports = [
    ../../modules/nixos
    ./configuration.nix
    ./hardware-configuration.nix
    ./keyboard.nix
  ];
}
