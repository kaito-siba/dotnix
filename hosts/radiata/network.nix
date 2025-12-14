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
  };
} 
