{ ragenix, mysecrets, ... }:
{
  age.identityPaths = [
    "/home/${username}/.ssh/id_ed25519"
  ];

  age.secrets."infra/siba_ultimate_pc" = {
    file = "${mysecrets}/infra/siba_ultimate_pc.pubkey.age";
    path = "/etc/ssh/authorized_keys.d/${username}";
    mode = "0400";
    owner = username;
  };
}
