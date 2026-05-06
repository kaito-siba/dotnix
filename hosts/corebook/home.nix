let
  wallpaperPath = "~/nixos/assets/wallpaper_3.jpg";
in
{
  # Define the user module as a function to receive { pkgs, ... }
  rkv12 =
    { pkgs, lib, ... }:
    let
      corebookNiriConfig = pkgs.writeText "corebook-niri-config.kdl" (
        lib.replaceStrings [ "        tap\n" ] [ "" ] (builtins.readFile ../../home/linux/niri/config.kdl)
      );
    in
    {
      imports = [
        ../../home/linux
      ];

      home = {
        username = "rkv12";
        homeDirectory = "/home/rkv12";
        stateVersion = "25.11";
        sessionVariables = {
          NIXOS_OZONE_WL = "1"; # Electron apps to use Wayland
        };
      };

      xdg.configFile."niri/config.kdl".source = lib.mkForce corebookNiriConfig;
      xdg.configFile."niri/outputs.kdl".source = lib.mkForce ./niri-outputs.kdl;
    };
}
