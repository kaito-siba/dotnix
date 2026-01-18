{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tuigreet
  ];

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --asterisks --cmd 'uwsm start niri-uwsm.desktop'";
      };
      default_session = initial_session;
    };
  };
}
