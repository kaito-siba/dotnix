{ pkgs, lib, ... }:
{
  services.activitywatch = {
    enable = true;
    watchers = { };
  };

  home.packages = [
    pkgs.awatcher
  ];

  systemd.user.services.awatcher = {
    Unit = {
      Description = "Awatcher for ActivityWatch";
      After = [
        "graphical-session.target"
        "activitywatch.service"
      ];
      Wants = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.awatcher}/bin/awatcher";
      Restart = "on-failure";
      RestartSec = 5;
      Environment = [
        "XDG_RUNTIME_DIR=/run/user/%U"
      ];
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
