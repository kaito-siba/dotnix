{ niri-blur, pkgs, ... }: {
  programs.niri = {
    enable = true;
    package = niri-blur.packages.${pkgs.system}.niri;
  };
}
