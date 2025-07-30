{ ... }: {
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
    ./configuration.nix
  ];

  users.users.w963n = {
    isNormalUser = true;
    description = "w963n";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "docker" ];
  };

  networking.hostName = "radiata";

  system.stateVersion = "24.11";
}
