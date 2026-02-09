{ ... }: {
  services.openssh = {
    enable = true;
    ports = [ 4824 ];
    settings = {
      PasswordAuthentication = false;
      X11Forwarding = true;
    };
  };

  networking = {
    hostName = "siba-ultimate-pc";
    firewall.allowedTCPPorts = [ 4824 ];
    interfaces.enp129s0 = { wakeOnLan.enable = true; };
    firewall = { allowedUDPPorts = [ 9 ]; };
  };
}
