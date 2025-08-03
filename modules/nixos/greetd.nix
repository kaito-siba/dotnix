{ ... }:
{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "hyprland > /dev/null 2>&1";
      };
      default_session = initial_session;
    };
  };
}
