{ pkgs, config, mysecrets, ... }:
let username = "w963n";
in {
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
    ./configuration.nix
    ./boot.nix
    ./network.nix
    ./user.nix
  ];

  programs.zsh.enable = true;
  users.users.${username} = {
    isNormalUser = true;
    description = "w963n";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "docker" ];
    shell = pkgs.zsh;
  };

  age.identityPaths = [ "/home/${username}/.ssh/id_ed25519" ];

  age.secrets."infra/siba_ultimate_pc" = {
    file = "${mysecrets}/infra/siba_ultimate_pc.pubkey.age";
    path = "/etc/ssh/authorized_keys.d/${username}";
    mode = "0400";
    owner = username;
  };

  programs.nh.flake = "/home/${username}/nixos";

  system.stateVersion = "25.05";
}
