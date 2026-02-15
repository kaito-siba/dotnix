{ pkgs, ... }:
{
  programs.rbw = {
    enable = true;
    settings = {
      email = "r.k.v.1225kaito@icloud.com";
      pinentry = pkgs.pinentry-gnome3;
    };
  };
}
