{ pkgs, ... }: {
  home.packages = with pkgs; [
    wl-clipboard
    cliphist
  ];

  # text
  systemd.user.services."cliphist-text" = {
    Unit = {
      Description = "cliphist store (text)";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store";
      Restart = "always";
      RestartSec = 1;
    };
    Install.WantedBy = [ "hyprland-session.target" ];
  };

  # image
  systemd.user.services."cliphist-image" = {
    Unit = {
      Description = "cliphist store (image)";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store";
      Restart = "always";
      RestartSec = 1;
    };
    Install.WantedBy = [ "hyprland-session.target" ];
  };

  home.file.".local/bin/clipmenu-wofi".text = ''
    #!${pkgs.bash}/bin/bash
    set -euo pipefail
    sel="$( ${pkgs.cliphist}/bin/cliphist list | ${pkgs.wofi}/bin/wofi --dmenu -p 'clipboard' -i )"
    [ -n "${sel:-}" ] || exit 0
    id="$(printf '%s\n' "$sel" | awk '{print $1}')"
    if ${pkgs.cliphist}/bin/cliphist decode "$id" | ${pkgs.wl-clipboard}/bin/wl-copy; then
      :
    else
      ${pkgs.cliphist}/bin/cliphist decode "$id" | ${pkgs.wl-clipboard}/bin/wl-copy --type image/png
    fi
    if command -v notify-send >/dev/null 2>&1; then
      notify-send "Clipboard" "Copied item #$id from history"
    fi
  '';
  home.file.".local/bin/clipmenu-wofi".executable = true;
}
