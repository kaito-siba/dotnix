{ pkgs, ... }:
{
    home.packages = with pkgs; [
      gcc
      zig
      llvmPackages.openmp
    ];
}
