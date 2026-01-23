{ pkgs, pkgs-unstable, ... }: {
  home.packages = with pkgs;
    [
      # archives
      zip
      xz
      unzip
      p7zip

      # utils
      ripgrep
      jq
      yq-go
      eza
      visidata

      ghq # Remote repository management made easy

      neofetch

      bat
      uv
      lazysql

      # aws
      awscli2
      ssm-session-manager-plugin

      postgresql

      fd
      with-shell
      lnav
      zeal
      mysql80
    ] ++ (with pkgs-unstable; [ devenv ]);

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.mpv = {
    enable = true;
  };
}
