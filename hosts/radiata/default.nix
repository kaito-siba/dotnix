{ ... }: {
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
    ./configuration.nix
  ];

  users.users.rkv12 = {
    isNormalUser = true;
    description = "rkv12";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "docker" ];
  };

  home = {
    username = "rkv12";
    homeDirectory = "/home/rkv12";
    stateVersion = "24.11";
    sessionVariables = {
      NIXOS_OZONE_WL = "1"; # Electron apps to use Wayland
    };
  };

  networking.hostName = "radiata";

  system.stateVersion = "24.11";
}
