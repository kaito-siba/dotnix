{ ... }:
{
  imports = [
    ../../modules/nixos
    ./configuration.nix
    ./hardware-configuration.nix
    ./keyboard.nix
  ];

  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "client";
    extraUpFlags = [ "--accept-dns=true" ];
    extraSetFlags = [
      "--ssh"
      "--operator=$USER"
    ];
  };
}
