{ ... }: {
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
    ./configuration.nix
    ./boot.nix
  ];

  users.users.w963n = {
    isNormalUser = true;
    description = "w963n";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "docker" ];
  };

  networking.hostName = "siba-ultimate-pc";

  system.stateVersion = "25.05";
}
