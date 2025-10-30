{ pkgs, ... }:
{
  users.users.soma = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "docker" ];
    shell = pkgs.zsh;
  };
}
