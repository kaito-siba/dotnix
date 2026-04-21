{ ... }:
{
  services.syncthing = {
    enable = true;
    tray.enable = false;

    overrideDevices = false;
    overrideFolders = false;
  };
}
