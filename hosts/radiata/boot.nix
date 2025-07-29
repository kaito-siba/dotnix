{ config, pkg, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # https://github.com/NixOS/nixpkgs/issues/316285
  boot.loader.grub.enable = false;
}
  
