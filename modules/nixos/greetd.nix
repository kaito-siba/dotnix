{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --asterisks --cmd 'uwsm start niri-uwsm.desktop'";
      };
      default_session = initial_session;
    };
  };
}
