{ ... }:
{
  services.openssh = {
    enable = true;
    ports = [ 4824 ];
    settings = {
        PasswordAuthentication = false;
    };
  };

  networking = {
    hostName = "siba-ultimate-pc";
    firewall.allowedTCPPorts = [ 4824 ];
    interfaces.end0.ipv4.addresses = [ {
      address = "10.48.6.174";
      prefixLength = 21;
    } ];
  };
} 
