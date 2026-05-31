{ config, pkgs, ... }:
let
  lycoPkg = pkgs.stdenv.mkDerivation {
    pname = "grub-theme-lycoris-recoil";
    version = "1.0";
    src = pkgs.fetchFromGitHub {
      owner = "13atm01"; 
      repo = "GRUB-Theme";
      rev = "Lyco-v1.0"; 
      hash = "sha256-yfXpMQCVpQjPdZ79f5tW5EkoGvRl3WZMIM0QRWzk/cQ=";
    };
    installPhase = ''
      mkdir -p $out/share/grub/themes
      cp -r "Kurumi/Kurumi" "$out/share/grub/themes/lyco"
    '';
  };
in
{
  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
    theme = "${lycoPkg}/share/grub/themes/lyco";
    gfxmodeEfi = "1920x1080";
    gfxpayloadEfi = "text";
  };
  
  boot.loader.efi.efiSysMountPoint = "/boot";
}
  
