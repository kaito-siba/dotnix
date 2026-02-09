{
  services.openssh = {
    enable = true;
    ports = [ 4824 ];
    settings = {
      PasswordAuthentication = false;
    };
  };

  networking = {
    hostName = "radiata";
    firewall.allowedTCPPorts = [ 4824 ];
    interfaces.enp4s0 = {
      wakeOnLan.enable = true;
    };
    firewall = {
      allowedUDPPorts = [ 9 ];
    };
  };
}
