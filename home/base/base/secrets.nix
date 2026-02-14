{ config, ragenix, ... }:
{
  imports = [
    ragenix.homeManagerModules.default
  ];

  age = {
    identityPaths = [
      "${config.home.homeDirectory}/.ssh/id_ed25519"
    ];
  };
}
