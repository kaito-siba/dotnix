{ config, pkg, ... }:

{
  fileSystems."/boot" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/sda3";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  fileSystems."/mnt/windows-esp" = {
    device = "/dev/nvme0n1p1";
    fsType = "vfat";
    options = [ "nofail" "ro" ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  
  # https://github.com/NixOS/nixpkgs/issues/316285
  boot.loader.grub.enable = false;

  boot.loader.systemd-boot.extraEntries = {
    "windows.conf" = ''
      title Windows 11
      efi /EFI/Microsoft/Boot/bootmgfw.efi
      sort-key 0
    '';
  };

  boot.loader.systemd-boot.extraFiles = {
    "EFI/Microsoft/Boot/bootmgfw.efi" = "/mnt/windows-esp/EFI/Microsoft/Boot/bootmgfw.efi";
    "EFI/Microsoft/Boot/BCD" = "/mnt/windows-esp/EFI/Microsoft/Boot/BCD";
  };

  boot.loader.timeout = 10;
}
  
