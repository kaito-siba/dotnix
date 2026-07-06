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

      # for dennotai
      interfaces."tailscale0".allowedTCPPorts = [ 8790 ];
    };
  };
}
