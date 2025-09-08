{ pkgs, ... }: {
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
    ./configuration.nix
    ./boot.nix
  ];

  programs.zsh.enable = true;
  users.users.rkv12 = {
    isNormalUser = true;
    description = "rkv12";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "docker" ];
    shell = pkgs.zsh;
  };

  networking.hostName = "radiata";

  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "client";
    # extraUpFlags = [ "--accept-dns=true" "--ssh" "--operator=$USER" ];
  };

  system.stateVersion = "24.11";
}
