{ pkgs, ... }:
{
  # https://github.com/tomrijndorp/vscode-finditfaster/issues/44
  services.envfs.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  # https://github.com/abenz1267/walker/README.md 
  nix.settings = {
    substituters = ["https://walker.cachix.org"];
    trusted-public-keys = ["walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="];
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib  # glibc, libstdc++ など
    zlib openssl
  ];
}
