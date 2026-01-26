{ pkgs, ... }: {
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gnome ];
  };

  environment.systemPackages = with pkgs;
    [
      xwayland-satellite # https://yalter.github.io/niri/Xwayland.html#using-xwayland-satellite
    ];
}
