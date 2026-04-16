{ niri, pkgs, ... }: {
  programs.niri = {
    enable = true;
    package = niri.packages.${pkgs.system}.niri;
  };
}
