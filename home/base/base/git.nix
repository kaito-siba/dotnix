{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "k-nanchi";
        email = "kaito@siba-service.jp";
      };
    };
    lfs.enable = true;
    ignores = [
      ".direnv/"
    ];
  };

  programs.difftastic = {
    enable = true;
    git = {
      enable = true;
      diffToolMode = true;
    };
  };
}
