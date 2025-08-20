{ ... }:
{
  programs.git = {
    enable = true;
    userName = "k-nanchi";
    userEmail = "kaito@siba-service.jp";
    delta = {
      enable = true;
    };
    ignores = [
      ".envrc"
      ".direnv/"
    ];
  }; 
}

