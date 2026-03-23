{ pkgs, ... }:
{
  services.activitywatch = {
    enable = true;
    watchers = {
      aw-watcher-window-wayland = {
        package = pkgs.aw-watcher-window-wayland;
        settings = {
          poll_time = 1;
          exclude_title = true;
        };
      };
    };
  };
}
