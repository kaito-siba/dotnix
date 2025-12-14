{ pkgs, ... }:let
  username = "rkv12";
in  {
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
    ./configuration.nix
    ./boot.nix
    ./network.nix
  ];

  # radiata 専用の overlay: tailscale のテストスキップを追加
  # https://github.com/tailscale/tailscale/issues/16966
  nixpkgs.overlays = [
    (
      _: prev: {
        tailscale = prev.tailscale.overrideAttrs (old: {
          checkFlags =
            builtins.map (
              flag:
                if prev.lib.hasPrefix "-skip=" flag
                then flag + "|^TestGetList$|^TestIgnoreLocallyBoundPorts$|^TestPoller$"
                else flag
            ) old.checkFlags;
        });
      }
    )
  ];

  programs.zsh.enable = true;
  users.users.rkv12 = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "docker" ];
    shell = pkgs.zsh;
  };

  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "client";
    extraUpFlags = [ "--accept-dns=true" ];
    extraSetFlags = [ "--ssh" "--operator=$USER" ];
  };

  programs.nh.flake = "/home/${username}/nixos";

  system.stateVersion = "24.11";
}
