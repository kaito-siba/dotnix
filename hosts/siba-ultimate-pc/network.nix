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
  };
} 
