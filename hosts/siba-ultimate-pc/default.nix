{ pkgs, ... }: {
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
    ./configuration.nix
    ./boot.nix
    ./network.nix
  ];

  programs.zsh.enable = true;
  users.users.w963n = {
    isNormalUser = true;
    description = "w963n";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "docker" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKHhELz0IRNMJXiIT6kjHJ36Z8IOlPnanK1nixZUpKVG w963n"
    ];
  };

  system.stateVersion = "25.05";
}
