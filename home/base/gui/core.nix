{ pkgs, pkgs-unstable, ... }: {
  home.packages = (with pkgs; [ dbeaver-bin google-chrome zeal ])
    ++ (with pkgs-unstable; [ slack discord obsidian ]);
}
