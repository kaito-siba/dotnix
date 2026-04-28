{ pkgs, lib, config, ... }:
let
  awSyncLocal = pkgs.writeShellScript "aw-sync-local" ''
    set -euo pipefail
    buckets=$(${pkgs.curl}/bin/curl -sf http://127.0.0.1:5600/api/0/buckets/ \
      | ${pkgs.jq}/bin/jq -r 'to_entries
          | map(select(.value.data["$aw.sync.origin"] == null))
          | map(.key) | join(",")')
    if [ -z "$buckets" ]; then
      echo "aw-sync-local: no local buckets found, skipping" >&2
      exit 0
    fi
    exec ${pkgs.aw-server-rust}/bin/aw-sync sync --mode both --buckets "$buckets"
  '';
in
{
  launchd.agents.aw-sync = {
    enable = true;
    config = {
      Label = "org.activitywatch.aw-sync-local";
      ProgramArguments = [ "${awSyncLocal}" ];
      StartInterval = 300;
      RunAtLoad = false;
      StandardOutPath = "${config.home.homeDirectory}/Library/Logs/aw-sync.log";
      StandardErrorPath = "${config.home.homeDirectory}/Library/Logs/aw-sync.log";
    };
  };
}
